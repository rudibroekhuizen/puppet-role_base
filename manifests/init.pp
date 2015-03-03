# == Class: role_base
#
# Full description of class role_base here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { role_base:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Rudi Broekhuizen <rudi.broekhuizen@naturalis.nl>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
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
