# == Class: role_base::workstation_work
#
class role_base::workstation_work {
  class { 'docker':
    use_upstream_package_source => false,
    docker_users                => ['rudi.broekhuizen'],
  }
  #class { 'sqlplus': }
  #class { 'role_burp': }
  #class { 'role_tftp': }
}
