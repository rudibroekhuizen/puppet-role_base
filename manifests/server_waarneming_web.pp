# == Class: role_base::server_waarneming_web
#
class role_base::server_waarneming_web {
  class { 'role_waarneming::common': }
  class { 'role_waarneming::conf': }
  #class { 'role_waarneming::django_app': }
  #class { 'role_waarneming::mail': }
  #class { 'role_waarneming::pgbouncer': }
  class { 'role_waarneming::php_app': }
  class { 'role_waarneming::phppgadmin': }
}
