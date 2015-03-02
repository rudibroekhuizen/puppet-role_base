# == Class: role_base
#
#
class role_base {
  include role_base::yaml
  
  class { 'base': }
}
