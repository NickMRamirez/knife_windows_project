#
# Cookbook Name:: chef_server
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

chef_server_url = node['chef_server']['url']
chef_package = ::File.basename(chef_server_url)
chef_package_local_path = "#{Chef::Config[:file_cache_path]}/#{chef_package}"
home_chef_dir = "/home/vagrant/.chef"

# Download Chef-server package
remote_file chef_package_local_path do
  source chef_server_url
end

# Create chef-server directory
directory '/etc/chef-server'

# Install chef-server
dpkg_package chef_package do
  source chef_package_local_path
  notifies :run, 'execute[reconfigure-chef-server]', :immediately
end

# Reconfigure chef-server
execute 'reconfigure-chef-server' do
  command 'sudo chef-server-ctl reconfigure'
  action :nothing
  notifies :run, 'execute[create-chef-admin]', :immediately
end

# Create chef admin user
execute 'create-chef-admin' do
  command 'sudo chef-server-ctl user-create admin Admin Admin test@test.com P@ssw0rd --filename /etc/chef-server/admin.pem'
  action :nothing
  notifies :run, 'execute[create-chef-org]', :immediately
end

# Create chef organization
execute 'create-chef-org' do
  command 'sudo chef-server-ctl org-create home Home --association_user admin --filename /etc/chef-server/home.pem'
  action :nothing
end

# Create .chef directory in /home/vagrant
directory home_chef_dir

# Copy knife.rb to server
cookbook_file "#{home_chef_dir}/knife.rb" do
  notifies :run, 'execute[knife-ssl-fetch]', :immediately
end

# Fetch chef SSL certificates
execute 'knife-ssl-fetch' do
  cwd home_chef_dir
  command 'sudo knife ssl fetch'
  action :nothing
end

# Create a cookbooks directory in /home/vagrant/.chef
directory "#{home_chef_dir}/cookbooks"

# Install the knife-windows gem
# package 'build-essential'
# package 'zlib1g'
# chef_gem 'knife-windows'
