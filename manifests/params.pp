# == Class rsyslog::params
#
# This class is meant to be called from rsyslog.
# It sets variables according to platform.
#
class rsyslog::params {
  $package_name = 'rsyslog'
  $package_ensure = 'present'

  $service_name = 'rsyslog'
  $service_ensure = 'running'

  $use_tcp = false
  $use_udp = true
  $listen_address = '127.0.0.1'

  $conffile = '/etc/rsyslog.conf'
  $logdir = '/srv/logs'

  case $::operatingsystem {
    'Debian', 'Ubuntu',
    'RedHat', 'CentOS',
    'Amazon': {
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
