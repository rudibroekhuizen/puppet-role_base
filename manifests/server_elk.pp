# == Class: role_base::server_elk
#
class role_base::server_elk {

  # Override default modules loaded by Puppetfile
  $vcsrepo_hash.each |$title, $vcsrepo| {
    vcsrepo { "/etc/puppetlabs/code/modules/${title}":
      provider => git,
      source   => $vcsrepo["source"],
    }
  }
  
  class { 'role_elasticsearch': }
  class { 'role_logstash': }
  class { 'kibana5': }
  
  #class { 'role_rsyslog': }
}

