# @summary
#   This class handles the configuration file.
# private class

class ntp::config {
  $config_content = epp('ntp/ntp.conf.epp')
  file { '/etc/ntp.conf':
    ensure => present,
    owner  => 0,
    group  => 0,
    mode   => '0600',
    content => $config_content,
  }

}
