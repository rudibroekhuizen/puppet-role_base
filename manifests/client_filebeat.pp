# == Class: role_base::client_filebeat
#
class role_base::client_filebeat {

  #class { 'filebeat': }

  apt::source { 'beats':
    location => 'https://artifacts.elastic.co/packages/5.x/apt',
    release  => 'stable',
    repos    => 'main',
    key      => {
      id     => '46095ACC8548582C1A2699A9D27D666CD88E42B4',
      source => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
    }
  }
}
