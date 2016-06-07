# == Class: role_base::client-openvpn
#
class role_base::client-openvpn (
  $client_hash,
) {

  create_resources('openvpn_client::client', $client_hash)

}
