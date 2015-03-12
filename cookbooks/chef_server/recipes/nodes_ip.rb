hostsfile_entry '192.168.50.2' do
  hostname 'chefserver'
  unique true
end

hostsfile_entry '192.168.50.3' do
  hostname 'node1'
  unique true
end
