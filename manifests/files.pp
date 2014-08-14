# == Class: role_base::files
#
class role_base::files {

# Hiera config file
  file { '/etc/puppet/hiera.yaml':
    source  => 'puppet:///modules/base/hiera.yaml',
  }

  # Create hieradata directory
  file { '/etc/puppet/hieradata':
    ensure => 'directory',
  }

  # Hiera user data
  file { '/etc/puppet/hieradata/global.yaml':
    source  => 'puppet:///modules/role_base/global.yaml',
    replace => false,
    require => File['/etc/puppet/hieradata'],
  }
  
}
