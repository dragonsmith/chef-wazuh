#
# Cookbook Name:: wazuh
# Recipe:: api
#
# Author:: Kirill Kuznetsov <agon.smith@gmail.com>
#
# Copyright 2017, Kirill Kouznetsov.

listen_interface = node['wazuh']['api']['config']['listen_interface']
listen_on = node['network']['interfaces'][listen_interface]['addresses'].find { |address, data| data['family'] == 'inet' }.first

package 'wazuh-api'

service 'wazuh-api' do
  action [:start, :enable]
end

if node['wazuh']['api']['config']['basic_auth'] == 'yes'
  htpasswd_secrets = Chef::EncryptedDataBagItem.load(node['wazuh']['data_bag_name'], 'htpasswd')

  htpasswd_data = htpasswd_secrets['users'].map do |k, v|
                    "#{k}:#{v.crypt(SecureRandom.base64(2)[1..2])}"
                  end

  file '/var/ossec/api/configuration/auth/user' do
    owner 'root'
    group 'ossec'
    mode '0640'
    content htpasswd_data.join("\n")
  end
end

if node['wazuh']['api']['config']['https'] == 'yes'
  tls_secrets = Chef::EncryptedDataBagItem.load(node['wazuh']['data_bag_name'], 'tls')

  %w(cert key).each do |filetype|
    file node['wazuh']['api']['config']["https_#{filetype}"] do
      owner 'root'
      group 'root'
      mode '0644'
      content tls_secrets[::File.basename(node['wazuh']['api']['config']["https_#{filetype}"])]
      notifies :restart, 'service[wazuh-api]', :delayed
    end
  end


  if node['wazuh']['api']['config']['https_use_ca'] == 'yes'
    file node['wazuh']['api']['config']['https_ca'] do
      owner 'root'
      group 'root'
      mode '0644'
      content tls_secrets[::File.basename(node['wazuh']['api']['config']['https_ca'])]
      notifies :restart, 'service[wazuh-api]', :delayed
    end
  end
end

template '/var/ossec/api/configuration/config.js' do
  source 'api.config.js.erb'
  owner 'root'
  group 'root'
  mode '0750'
  variables node['wazuh']['api']['config'].to_h.merge(
    listen_on: listen_on
  )
  notifies :restart, 'service[wazuh-api]', :delayed
end
