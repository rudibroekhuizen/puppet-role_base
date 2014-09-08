# == Class: role_base
#
#
class role_base (
  $package_attribute_defaults = { ensure   => installed,
                                },

  $package_hash_debian = { 'puppet' => { ensure   => latest,
                                       },

                           'htop'   => { ensure   => latest,
                                       },
                         },
                         
  $package_hash_redhat = { 'puppet' => { ensure   => latest,
                                       },

                           'git'    => { ensure   => latest,
                                       },
                         },
                         
  $user_attribute_defaults = { ensure => present,
                             },
                             
  $user_hash = { 'rudi.broekhuizen' => { password => Passw0rd,
                                         groups   => admin,
                                         ensure   => present,
                                       },
               },
  ) {

# Various configure items
  class { 'base::config':
  }

# Install files
  class { 'base::files':
  }

# Install packages
  class { 'base::packages':
    package_hash_debian         => $package_hash_debian,
    package_hash_redhat         => $package_hash_redhat,
    package_attribute_defaults  => $package_attribute_defaults,
    require                     => Host[$::fqdn],
  }
  
# Create users
  class { 'base::users':
    user_hash                => $user_hash,
    user_attribute_defaults  => $user_attribute_defaults,
  }  

}
