# ntp
#
# Main class, includes all other classes.
#
# @param driftfile
#   Specifies an NTP driftfile. Default value: '/var/lib/ntp/drift'
# @param package_ensure
#   Whether to install the NTP package, and what version to install. Values: 'present', 'latest', or a specific version number.
#   Default value: 'present'.
# @param servers
#   Specifies one or more servers to be used as NTP peers.
# @param service_ensure
#   Whether the NTP service should be running. Default value: 'running'.
# @param service_enable
#   Whether to enable the NTP service at boot. Default value: true.
class ntp (
  String  $driftfile,
  String  $package_ensure,
  Array   $servers,
  Enum['stopped','running']  $service_ensure,
  Boolean  $service_enable,
) {

  contain ntp::install
  contain ntp::config
  contain ntp::service
  Class['::ntp::install']
  -> Class['::ntp::config']
  ~> Class['::ntp::service']
}

