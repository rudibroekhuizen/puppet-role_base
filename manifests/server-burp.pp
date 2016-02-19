# == Class: role_base::server-elk
#
class role_base::server-elk {
  class { 'base': } ->
  class { 'role_burp': }
}
