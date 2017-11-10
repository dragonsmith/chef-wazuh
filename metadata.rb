name             'wazuh'
maintainer       'Kirill Kuznetsov'
maintainer_email 'agon.smith@gmail.com'
license          'All rights reserved'
description      'A tiny recipe to automate Wazuh server installation.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

supports 'ubuntu'
supports 'debian'

depends 'filebeat'
depends 'cron'
