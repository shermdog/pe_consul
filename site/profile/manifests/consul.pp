# Class: profile::consul
#
# This class is expected to be wrapped by profile::consul::server
# or by profile::consul::agent
class profile::consul (
  $version = '0.6.4',
  $expected_cluster_size = 3,
  $datacenter = 'dc1',
  $server = false
) {

  $servers = query_nodes("stage=${::stage} and Class[Profile::Consul::Server]", ipaddress)
  $agents  = query_nodes("stage=${::stage} and Class[Profile::Consul::Agent]", ipaddress)


  if $debug {
    notify {"consul server list: ${servers}": }
    notify {"consul agent list: ${agents}": }
  }

  class { '::consul':
    config_hash => {
      'bootstrap_expect' => $expected_cluster_size,
      'data_dir'         => '/opt/consul',
      'datacenter'       => $datacenter,
      'log_level'        => 'INFO',
      'node_name'        => $::fqdn,
      'server'           => $server,
      'retry_join'       => $servers,
    }
  }
}
