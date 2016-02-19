# == Class: role_base::server-elk
#
class role_base::server-elk {
  class { 'role_elasticsearch': } ->
  class { 'kibana': }
}
