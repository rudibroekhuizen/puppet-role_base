# == Class: role_base::client-openvpn
#
class role_base::client-openvpn {
  class { 'openvpn_client': }
}
