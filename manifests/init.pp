# == Class: role_base
#
#
class role_base (
  $repos_array_debian = [ 'ppa:webupd8team/atom',
                          'ppa:webupd8team/java',
                        ],
                
  $packages_attribute_defaults = { ensure => installed,
                                 },

  $packages_hash_debian = { 'puppet' => { ensure => latest,
                                        },

                            'htop'   => { ensure => latest,
                                        },
                          },
                         
  $packages_hash_redhat = { 'puppet' => { ensure => latest,
                                        },

                            'htop'   => { ensure => latest,
                                        },
                          },
                         
  $users_attribute_defaults = { ensure => present,
                              },
                             
  $users_hash = { 'rudi.broekhuizen' => { comment => 'Rudi Broekhuizen',
                                          email   => 'rudi.broekhuizen@naturalis.nl',
                                          groups  => ['wheel','sudo','adm','plugdev'],
                                          ensure  => present,
                                          shell   => '/bin/zsh',
                                          ssh_key => { type => "ssh-rsa",
                                                       key  => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDeRrVuojExYBWgIV7UlLfYLvzGpW9hSzrjl9qJ7Kb3E/x+kq2ruma3LXlvMzFXoCKJMYvqvXUFj2Dzwh+iJ2bCyh5ilWgTMLvAwzRl1LdAV8IbDVYNZGCHCzXkyxLMAEdxXMHVYl6N/q+RBP+HQCySpwOjv86c5PgXoL4BOnxLy5TAoxSsfvxRcHT42ThYK1C/R5QC8UoBdpJ1RBhQRjBJPMWp9zRyOafNwE7Iti15gKHp04bn9UGqHRTA1ul+Q6YEFzjoqUxe4VCHObM6BS/DpD++TPMXjzU+aeJ8tkxhmYkGRKYJx/KK3uaKPv+/EkODePvwTVshiQ8v9qOXx0YJ",
                                                     },
                                        },
               },
  ) {

# Various configure items
  class { 'base::config':
    owner_email => $owner_email
  }

# Install files
  class { 'base::files':
    require => Class ['base::config'],
  }

# Add repositories
  class { 'base::repos':
    repos_array_debian => $repos_array_debian,
    require            => Class ['base::files'],
  }

# Install packages
  class { 'base::packages':
    packages_hash_debian        => $packages_hash_debian,
    packages_hash_redhat        => $packages_hash_redhat,
    packages_attribute_defaults => $packages_attribute_defaults,
    require                     => Class ['base::repos'],
  }
  
# Create users
  class { 'base::users':
    users_hash               => $users_hash,
    users_attribute_defaults => $users_attribute_defaults,
    require                  => Class ['base::packages'],
  }  

}
