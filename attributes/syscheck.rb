default['wazuh']['config']['syscheck']['disabled']        = 'no'
default['wazuh']['config']['syscheck']['frequency']       = '43200'
default['wazuh']['config']['syscheck']['scan_on_start']   = 'yes'
default['wazuh']['config']['syscheck']['alert_new_files'] = 'yes'
default['wazuh']['config']['syscheck']['auto_ignore']     = 'no'
default['wazuh']['config']['syscheck']['skip_nfs']        = 'yes'

default['wazuh']['config']['syscheck']['prefilter_cmd']   = nil
default['wazuh']['config']['syscheck']['scan_day']        = []
default['wazuh']['config']['syscheck']['scan_time']       = nil

default['wazuh']['config']['syscheck']['directories'] = [
  Mash.new(
    'paths' => %w(
      /etc
      /usr/bin
      /usr/sbin
      /bin
      /sbin
      /boot
    )
  )
]

default['wazuh']['config']['syscheck']['ignore'] = %w(
  /etc/mtab
  /etc/hosts.deny
  /etc/mail/statistics
  /etc/random-seed
  /etc/random.seed
  /etc/adjtime
  /etc/utmpx
  /etc/wtmpx
  /etc/cups/certs
  /etc/dumpdates
  /etc/svc/volatile
)

default['wazuh']['config']['syscheck']['nodiff'] = %w(
  /etc/ssl/private.key
)
