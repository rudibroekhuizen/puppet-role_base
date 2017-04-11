# == Class role_base::client_phppgadmin
#
class role_base::client_phppgadmin (
  $path     = '/srv/phppgadmin',
  $user     = 'www-data',
  $servers  = [],
  $revision = 'origin/REL_5-1'
) {

  file { $path:
    ensure => directory,
    owner  => $user,
  } ->
  
  vcsrepo { $path:
    ensure   => present,
    provider => git,
    source   => 'git://github.com/phppgadmin/phppgadmin.git',
    user     => $user,
    revision => $revision,
  }
  
  class { 'nginx': }
  
  nginx::resource::server { 'phppgadmin':
    www_root => '/srv/phppgadmin', 
  }

}
