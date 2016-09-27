# == Class: role_base::server_burp
#
class role_base::server_burp {
  class { 'base': } ->
  class { 'role_burp': }
}
