default['wazuh']['config']['wodle-openscap']['disabled']      = 'no'
default['wazuh']['config']['wodle-openscap']['timeout']       = 1800
default['wazuh']['config']['wodle-openscap']['interval']      = '1d'
default['wazuh']['config']['wodle-openscap']['scan_on_start'] = 'yes'
default['wazuh']['config']['wodle-openscap']['content'] = [
  Mash.new(
    'type'    => 'xccdf',
    'path'    => 'ssg-ubuntu-1604-ds.xml',
    'profile' => 'xccdf_org.ssgproject.content_profile_common'
  )
]
