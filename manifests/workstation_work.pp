# == Class: role_base::workstation_work
#
class role_base::workstation_work {
  class { 'base': } ->
  class { 'sqlplus': }
  class { 'role_burp': }
  class { 'role_tftp': }
}
