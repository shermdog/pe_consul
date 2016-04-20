# profile::consul::server
#
class profile::consul::server {

  class {'profile::consul':
    server => true
  }
}