# == Class: role_base::workstation_work
#
class role_base::workstation_work {
  class { 'docker':
    version => 'latest',
  }
  #class { 'sqlplus': }
  #class { 'role_burp': }
  #class { 'role_tftp': }
}
