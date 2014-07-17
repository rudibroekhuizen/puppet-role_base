# == Class: role_base::packages
#
class role_base::packages (
  $package_hash,
  $attribute_defaults,
  ){

case $::osfamily {
  debian: { create_resources('base::packages', $package_hash_debian, $attribute_defaults) }
  redhat: { create_resources('base::packages', $package_hash_redhat, $attribute_defaults) }

}
