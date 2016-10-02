# == Class: role_base::server_logstash
#
class role_base::server_logstash {
  include base
  class { 'role_logstash': 
    require base
  }
}
