default['wazuh']['config']['listen_interface'] = 'eth1'

default['wazuh']['data_bag_name'] = 'wazuh'

default['wazuh']['config']['smtp_server']        = 'localhost'
default['wazuh']['config']['email_from']         = 'wazuh@example.com'
default['wazuh']['config']['email_to']           = 'admin@example.com'
default['wazuh']['config']['email_notification'] = true

default['wazuh']['config']['log_alert_level']   = 3
default['wazuh']['config']['email_alert_level'] = 12

default['wazuh']['config']['log_format'] = 'plain'
