# == Class: role_base::server_elk
#
class role_base::server_elk {
  class { 'role_elasticsearch': } ->
  class { 'kibana': }
}
