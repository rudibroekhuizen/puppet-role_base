# == Class: role_base::client-openvpn
#
class role_base::client-openvpn (
  $openvpn_client_hash,
) {

  create_resources('openvpn_client::client', $openvpn_client_hash)

}
