# == Class: role_base::workstation_work
#
class role_base::workstation_work {

# Puppet modules needed
base::vcsrepo_hash:
  'elasticsearch':
    source: 'https://github.com/elastic/puppet-elasticsearch'
  'role_elasticsearch':
    source: 'https://github.com/rudibroekhuizen/puppet-role_elasticsearch'

  #class { 'sqlplus': }
  #class { 'role_burp': }
  #class { 'role_tftp': }
}
