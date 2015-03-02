# == Class: role_base
#
#
class role_base (
  $owner_email = 'email'
  ) {
  
  class { 'base':
    owner_email => bla,  
  }

}
