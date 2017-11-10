#
# Cookbook Name:: wazuh
# Recipe:: filebeat
#
# Author:: Kirill Kuznetsov <agon.smith@gmail.com>
#
# Copyright 2017, Kirill Kouznetsov.

tls_secrets = nil

directory '/etc/filebeat' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

service 'filebeat' do
  action :nothing
end

if node['filebeat']['config']['output.logstash'].key?('ssl.certificate_authorities') &&
   !node['filebeat']['config']['output.logstash']['ssl.certificate_authorities'].empty?

  tls_secrets = Chef::EncryptedDataBagItem.load(node['wazuh']['data_bag_name'], 'tls')

  node['filebeat']['config']['output.logstash']['ssl.certificate_authorities'].each do |filename|
    file filename do
      owner 'root'
      group 'root'
      mode '0644'
      content tls_secrets[::File.basename(filename)]
      notifies :restart, 'service[filebeat]', :delayed
    end
  end
end

if node['filebeat']['config']['output.logstash'].key?('ssl.certificate') &&
   node['filebeat']['config']['output.logstash']['ssl.certificate'] != '' &&
   node['filebeat']['config']['output.logstash'].key?('ssl.key') &&
   node['filebeat']['config']['output.logstash']['ssl.key'] != ''

  file node['filebeat']['config']['output.logstash']['ssl.certificate'] do
    owner 'root'
    group 'root'
    mode '0644'
    content tls_secrets[::File.basename(node['filebeat']['config']['output.logstash']['ssl.certificate'])]
    notifies :restart, 'service[filebeat]', :delayed
  end

  file node['filebeat']['config']['output.logstash']['ssl.key'] do
    owner 'root'
    group 'root'
    mode '0644'
    content tls_secrets[::File.basename(node['filebeat']['config']['output.logstash']['ssl.key'])]
    notifies :restart, 'service[filebeat]', :delayed
  end
end

include_recipe 'filebeat'

filebeat_prospector 'wazuh-alerts' do
  input_type 'log'
  paths ['/var/ossec/logs/alerts/alerts.json']
  document_type 'json'
  json_message_key 'log'
  json_keys_under_root true
  json_overwrite_keys true
end
