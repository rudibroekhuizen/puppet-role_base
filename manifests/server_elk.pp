# == Class: role_base::server_elk
#
class role_base::server_elk {

  stage { 'pre':
    before => Stage["main"],
  }

  # Download Puppet modules from Github
  class { 'misc::vcsrepo': 
    stage => pre
  }

  #class { 'role_elasticsearch': }
  class { 'role_logstash': }
  #class { 'kibana5': }
  
  #class { 'role_rsyslog': }
}
