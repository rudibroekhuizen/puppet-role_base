# == Class: role_base
#
#
class role_base (
  $owner_email,
  ) {
  
  class { 'base':
    owner_email => $owner_email  
  }

}
