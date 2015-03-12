# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.provider 'virtualbox'

  # Chef server - Ubuntu 14.04
  config.vm.define 'chefserver' do |server|
    server.vm.box = 'chef/ubuntu-14.04'
    server.vm.hostname = 'chefserver'
    server.vm.network 'private_network', ip: '192.168.50.2'

    server.vm.provision 'chef_solo' do |chef|
      chef.add_recipe 'chef_server'
      chef.add_recipe 'chef_server::nodes_ip'
    end
  end

  # Node 1 - Windows 2012 R2
  config.vm.define 'node1' do |node|
    node.vm.box = 'scorebig/windows-2012R2-SC'
    node.vm.hostname = 'node1'
    node.vm.network 'private_network', ip: '192.168.50.3'

    node.vm.communicator = :winrm
    node.vm.guest = :windows
    node.vm.boot_timeout = 320
    node.vm.network 'forwarded_port', host: 33389, guest: 3389
    node.vm.provider 'virtualbox' do |v|
      v.gui = false
    end
  end

end
