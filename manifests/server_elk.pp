# == Class: role_base::server_elk
#
class role_base::server_elk {

  $vcsrepo_hash.each |$title, $vcsrepo| {
    vcsrepo { $title:
      provider => git,
      source   => $vcsrepo["source"],
    }
  }
  
  class { 'role_elasticsearch': }
  class { 'role_logstash': }
  class { 'kibana5': }
  
  #class { 'role_rsyslog': }
}

