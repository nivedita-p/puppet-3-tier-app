# @summary
#   This class handles the ntp service.
#

class ntp::service {

    service { 'ntpd':
      ensure     => $ntp::service_ensure,
      enable     => $ntp::service_enable,
      hasstatus  => true,
      hasrestart => true,
    }

}
