# == Class: role_base::server_elk
#
class role_base::server_elk {

  concat::fragment{ 'common':
    target => /etc/puppetlabs/puppet/Puppetfile,
    source => 'puppet:///modules/role_base/files/Puppetfile',
    order  => '01'
  }

  concat::fragment{ 'specific':
    target => /etc/puppetlabs/puppet/Puppetfile,
    source => 'puppet:///modules/server_elk/files/Puppetfile',
    order  => '02'
  }
  
  class { 'role_elasticsearch': }
  class { 'role_logstash': }
  class { 'kibana5': }
  
  #class { 'role_rsyslog': }
}
