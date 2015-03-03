# == Class: role_base
#
#
class role_base (
  $repos_array_debian          = undef,
  $owner_email                 = undef,
  $packages_attribute_defaults = undef,
  $packages_hash_debian        = undef,
  $packages_hash_redhat        = undef,
  $users_attribute_defaults    = undef,
  $users_hash                  = undef,
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
