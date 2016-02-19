# == Class: role_base::server-elk
#
class role_base::server-elk {
  include role_elasticsearch
  include kibana
}
