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
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class role_base (
  $attribute_defaults = { ensure   => installed,
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
  ) {

# Install files
   class { 'role_base::files':
   }

# Install packages
  class { 'role_base::packages':
    package_hash_debian => $package_hash_debian,
    package_hash_redhat => $package_hash_redhat,
    attribute_defaults  => $attribute_defaults,
  }

}
