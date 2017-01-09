# == Class: role_base::server_elk
#
class role_base::server_elk {
  class { 'role_elasticsearch': }
  class { 'role_logstash': }
  class { 'kibana': }
  
  class { 'role_rsyslog': }
}
