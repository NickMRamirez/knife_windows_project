log_level                :info
log_location             STDOUT
node_name                'admin'
client_key               '/etc/chef-server/admin.pem'
validation_client_name   'home-validator'
validation_key           '/etc/chef-server/home-validator.pem'
chef_server_url          'https://chefserver/organizations/home'
syntax_check_cache_path  '/home/vagrant/.chef/syntax_check_cache'
cookbook_path [ '/home/vagrant/.chef/cookbooks' ]
