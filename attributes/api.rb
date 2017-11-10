default['wazuh']['api']['config']['listen_interface'] = 'eth1'

# Basic configuration
default['wazuh']['api']['config']['basic_auth']        = 'no'
default['wazuh']['api']['config']['ossec_path']        = '/var/ossec'
default['wazuh']['api']['config']['port']              = 55000
default['wazuh']['api']['config']['BehindProxyServer'] = 'no'
default['wazuh']['api']['config']['https']        = 'no'

# HTTPS configuration

default['wazuh']['api']['config']['https_key']    = nil
default['wazuh']['api']['config']['https_cert']   = nil
default['wazuh']['api']['config']['https_ca']     = nil
default['wazuh']['api']['config']['https_use_ca'] = 'no'

# Advanced configuration
default['wazuh']['api']['config']['logs']            = 'info'
default['wazuh']['api']['config']['cors']            = 'yes'
default['wazuh']['api']['config']['cache_enabled']   = 'yes'
default['wazuh']['api']['config']['cache_debug']     = 'no'
default['wazuh']['api']['config']['cache_time']      = 750
default['wazuh']['api']['config']['log_path']        = "#{node['wazuh']['api']['config']['ossec_path']}/logs/api.log"
default['wazuh']['api']['config']['ld_library_path'] = "#{node['wazuh']['api']['config']['ossec_path']}/api/framework/lib"

# TODO
# default['wazuh']['api']['config']['python'] = 'no'
