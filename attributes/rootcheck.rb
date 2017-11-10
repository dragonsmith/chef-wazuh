# Attributes to configure rootcheck section.

default['wazuh']['config']['rootcheck']['base_directory']  = '/var/ossec'

default['wazuh']['config']['rootcheck']['disabled']        = 'no'
default['wazuh']['config']['rootcheck']['check_unixaudit'] = 'yes'
default['wazuh']['config']['rootcheck']['check_files']     = 'yes'
default['wazuh']['config']['rootcheck']['check_trojans']   = 'yes'
default['wazuh']['config']['rootcheck']['check_dev']       = 'yes'
default['wazuh']['config']['rootcheck']['check_sys']       = 'yes'
default['wazuh']['config']['rootcheck']['check_pids']      = 'yes'
default['wazuh']['config']['rootcheck']['check_ports']     = 'yes'
default['wazuh']['config']['rootcheck']['check_if']        = 'yes'
default['wazuh']['config']['rootcheck']['skip_nfs']        = 'yes'
default['wazuh']['config']['rootcheck']['frequency']       = 43200

default['wazuh']['config']['rootcheck']['scanall']         = 'no'

default['wazuh']['config']['rootcheck']['rootkit_files']   = '/var/ossec/etc/shared/rootkit_files.txt'
default['wazuh']['config']['rootcheck']['rootkit_trojans'] = '/var/ossec/etc/shared/rootkit_trojans.txt'

default['wazuh']['config']['rootcheck']['system_audit']    = %w(
  /var/ossec/etc/shared/system_audit_rcl.txt
  /var/ossec/etc/shared/system_audit_ssh.txt
  /var/ossec/etc/shared/cis_debian_linux_rcl.txt
)
