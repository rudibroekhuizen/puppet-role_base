# == Class: role_base
#
#
class role_base (
  $repos_array_debian,
  $owner_email,
  $packages_attribute_defaults,
  $packages_hash_debian,
  $packages_hash_redhat,
  $users_attribute_defaults,
  $users_hash,
  ) {
  
  class { 'base':
    repos_array_debian          => $repos_array_debian,
    owner_email                 => $owner_email,
    packages_attribute_defaults => $packages_attribute_defaults,
    packages_hash_debian        => $packages_hash_debian,
    packages_hash_redhat        => $packages_hash_redhat,
    users_attribute_defaults    => $users_attribute_defaults,
    users_hash                  => $users_hash,
  }

}
