# == Class: base::files
#
class base::files {

  # Hiera user data
  file { '/etc/puppet/hieradata/global.yaml':
    source  => 'puppet:///modules/base/global.yaml',
    replace => false,
  }
  
}
