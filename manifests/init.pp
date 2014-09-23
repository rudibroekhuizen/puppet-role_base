# == Class: role_base
#
#
class role_base (
  $ppas_array = [ 'ppa:webupd8team/atom', 'ppa:googlegadgets/ppa' ]
  $package_attribute_defaults = { ensure => installed,
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
                             
  $users_hash = { 'rudi.broekhuizen' => { comment  => 'Rudi Broekhuizen',
                                          groups   => 'wheel',
                                          ensure   => present,
                                          shell    => '/bin/zsh',
                                          ssh_key  => { type    => "ssh-rsa",
                                                        comment => "rudi.broekhuizen@naturalis.nl",
                                                        key     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDeRrVuojExYBWgIV7UlLfYLvzGpW9hSzrjl9qJ7Kb3E/x+kq2ruma3LXlvMzFXoCKJMYvqvXUFj2Dzwh+iJ2bCyh5ilWgTMLvAwzRl1LdAV8IbDVYNZGCHCzXkyxLMAEdxXMHVYl6N/q+RBP+HQCySpwOjv86c5PgXoL4BOnxLy5TAoxSsfvxRcHT42ThYK1C/R5QC8UoBdpJ1RBhQRjBJPMWp9zRyOafNwE7Iti15gKHp04bn9UGqHRTA1ul+Q6YEFzjoqUxe4VCHObM6BS/DpD++TPMXjzU+aeJ8tkxhmYkGRKYJx/KK3uaKPv+/EkODePvwTVshiQ8v9qOXx0YJ",
                                                      },
                                        },
               },
  ) {

# Various configure items
  class { 'base::config':
  }

# Install files
  class { 'base::files':
  }

# Add ppas
  class { 'base::ppas':
  }

# Install packages
  class { 'base::packages':
    package_hash_debian         => $package_hash_debian,
    package_hash_redhat         => $package_hash_redhat,
    package_attribute_defaults  => $package_attribute_defaults,
    require                     => [Host[$::fqdn],
                                    Class ['base::ppas']],
  }
  
# Create users
  class { 'base::users':
    user_hash                => $user_hash,
    user_attribute_defaults  => $user_attribute_defaults,
  }  

}
