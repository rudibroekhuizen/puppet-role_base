# == Class: role_base::files
#
class role_base::files {

  # Hiera user data
  file { '/etc/puppet/hieradata/global.yaml':
    source  => 'puppet:///modules/role_base/global.yaml',
    replace => false,
  }
  
}
