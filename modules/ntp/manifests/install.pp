# @summary
#   This class handles ntp packages.
#
class ntp::install {
  package {'ntp':
    ensure  => $ntp::package_ensure,
  }

}
