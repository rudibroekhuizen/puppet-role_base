# == Class: role_base::packages
#
class role_base::packages (
  $package_hash,
  $attribute_defaults,
  ){

  create_resources('base::packages', $package_hash, $attribute_defaults)
  
}
