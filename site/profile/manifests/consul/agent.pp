# profile::consul::agent
#
class profile::consul::agent (
  $enable = false ) {
  if $enable {

    class {'profile::consul':
      server => false
    }
  }
}