default['wazuh']['config']['localfile']['files'] = [
  Mash.new(
    log_format: 'command',
    command:    'df -P',
    frequency:  360
  ),

  Mash.new(
    log_format: 'full_command',
    command:    'netstat -tulpen | sort',
    alias:      'netstat listening ports',
    frequency:  360
  ),

  Mash.new(
    log_format: 'full_command',
    command:    'last -n 20',
    frequency:  360
  ),

  Mash.new(
    log_format: 'syslog',
    location: '/var/ossec/logs/active-responses.log'
  ),

  Mash.new(
    log_format: 'syslog',
    location: '/var/log/auth.log'
  ),

  Mash.new(
    log_format: 'syslog',
    location: '/var/log/syslog'
  ),

  Mash.new(
    log_format: 'syslog',
    location: '/var/log/dpkg.log'
  ),

  Mash.new(
    log_format: 'syslog',
    location: '/var/log/kern.log'
  )
]
