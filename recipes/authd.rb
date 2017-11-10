#
# Cookbook Name:: wazuh
# Recipe:: authd
#
# Author:: Kirill Kuznetsov <agon.smith@gmail.com>
#
# Copyright 2017, Kirill Kuznetsov.
#

execute 'Enable ossec-authd' do
  command '/var/ossec/bin/ossec-control enable auth'
  only_if { node['wazuh']['config']['auth']['disabled'] == 'no' }
  action :run
end

execute 'Disable ossec-authd' do
  command '/var/ossec/bin/ossec-control disable auth'
  only_if { node['wazuh']['config']['auth']['disabled'] != 'no' }
  action :run
end

service 'wazuh-manager' do
  action [:nothing]
end

if node['wazuh']['config']['auth']['ssl_agent_ca'] &&
   node['wazuh']['config']['auth']['ssl_agent_ca'] != ''
  tls_secrets = Chef::EncryptedDataBagItem.load(node['wazuh']['data_bag_name'], 'tls')

  file node['wazuh']['config']['auth']['ssl_agent_ca'] do
    owner 'root'
    group 'root'
    mode '0644'
    content tls_secrets[::File.basename(node['wazuh']['config']['auth']['ssl_agent_ca'])]
    notifies :restart, 'service[wazuh-manager]', :delayed
  end
end

if node['wazuh']['config']['auth']['ssl_manager_cert'] &&
   node['wazuh']['config']['auth']['ssl_manager_key'] &&
   node['wazuh']['config']['auth']['ssl_manager_cert'] != '' &&
   node['wazuh']['config']['auth']['ssl_manager_key'] != ''
  tls_secrets = Chef::EncryptedDataBagItem.load(node['wazuh']['data_bag_name'], 'tls')

  %w(cert key).each do |filetype|
    file node['wazuh']['config']['auth']["ssl_manager_#{filetype}"] do
      owner 'root'
      group 'root'
      mode '0644'
      content tls_secrets[::File.basename(node['wazuh']['config']['auth']["ssl_manager_#{filetype}"])]
      notifies :restart, 'service[wazuh-manager]', :delayed
    end
  end
end
