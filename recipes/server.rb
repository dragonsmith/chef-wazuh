#
# Cookbook Name:: wazuh
# Recipe:: server
#
# Author:: Kirill Kuznetsov <agon.smith@gmail.com>
#
# Copyright 2017, Kirill Kuznetsov.
#

listen_interface = node['wazuh']['config']['listen_interface']
listen_on = node['network']['interfaces'][listen_interface]['addresses'].find { |address, data| data['family'] == 'inet' }.first

apt_repository 'wazuh' do
  uri 'https://packages.wazuh.com/apt'
  distribution node['lsb']['codename']
  components ['main']
  key 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
  only_if { node['platform_family'] == 'debian' }
end

apt_repository 'nodesource-6.x' do
  uri 'https://deb.nodesource.com/node_6.x'
  distribution node['lsb']['codename']
  components ['main']
  key 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key'
end

package %w(
  curl
  apt-transport-https
  lsb-release
  nodejs
  wazuh-manager
)

service 'wazuh-manager' do
  action :nothing
end

template '/var/ossec/etc/ossec.conf' do
  owner 'root'
  group 'root'
  mode '0640'
  source 'ossec.conf.erb'
  variables(
    listen_on: listen_on,
    email_notification: node['wazuh']['config']['email_notification'],
    smtp_server: node['wazuh']['config']['smtp_server'],
    email_from: node['wazuh']['config']['email_from'],
    email_to: node['wazuh']['config']['email_to'],
    log_alert_level: node['wazuh']['config']['log_alert_level'],
    email_alert_level: node['wazuh']['config']['email_alert_level'],
    log_format: node['wazuh']['config']['log_format'],
    remote: node['wazuh']['config']['remote'],
    rootcheck: node['wazuh']['config']['rootcheck'],
    wodle_openscap: node['wazuh']['config']['wodle-openscap'],
    syscheck: node['wazuh']['config']['syscheck'],
    localfile: node['wazuh']['config']['localfile'],
    auth: node['wazuh']['config']['auth']
  )
  notifies :restart, 'service[wazuh-manager]'
end

service 'wazuh-manager' do
  action [:enable, :start]
end

# It is a hack, see https://groups.google.com/forum/#!topic/wazuh/Y2pEShwmZMw
cron 'set group ownership to ossec for ossec.log' do
  action node.tags.include?('cookbooks-report') ? :create : :delete
  minute '*/1'
  user 'root'
  command 'chgrp ossec /var/ossec/log/ossec.log'
end

include_recipe 'wazuh::authd'
include_recipe 'wazuh::api'
include_recipe 'wazuh::filebeat'
