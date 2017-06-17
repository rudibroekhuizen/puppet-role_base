# == Class: role_base::server_elk
#
class role_base::server_elk {


  class { 'misc::vcsrepo': }
  #class { 'role_elasticsearch': }
  class { 'role_logstash': }
  class { 'kibana5': }
  
  #class { 'role_rsyslog': }
}
