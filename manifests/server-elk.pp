# == Class: server-elk
#
class server-elk {
  include role_elasticsearch
  include kibana
}
