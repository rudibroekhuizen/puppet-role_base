# == Class: role_base::server_logstash
#
class role_base::server_logstash {
  class { 'role_logstash': }
}
