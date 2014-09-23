# == Class: role_base
#
#
class role_base (
  $ppas_array = [ 'ppa:webupd8team/atom',
                  'ppa:nilarimogard/webupd8',
                ],
                
  $packages_attribute_defaults = { ensure => installed,
                                 },

  $packages_hash_debian = { 'puppet' => { ensure   => latest,
                                        },

                            'htop'   => { ensure   => latest,
                                        },
                          },
                         
  $packages_hash_redhat = { 'puppet' => { ensure   => latest,
                                        },

                            'git'    => { ensure   => latest,
                                        },
                          },
                         
  $users_attribute_defaults = { ensure => present,
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
    ppas_array => $ppas_array,
  }

# Install packages
  class { 'base::packages':
    packages_hash_debian        => $packages_hash_debian,
    packages_hash_redhat        => $packages_hash_redhat,
    packages_attribute_defaults => $packages_attribute_defaults,
    require                     => [Host[$::fqdn],
                                    Class ['base::ppas']],
  }
  
# Create users
  class { 'base::users':
    users_hash                => $users_hash,
    users_attribute_defaults  => $users_attribute_defaults,
  }  

}
