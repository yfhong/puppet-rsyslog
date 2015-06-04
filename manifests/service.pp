# == Class rsyslog::service
#
# This class is meant to be called from rsyslog.
# It ensure the service is running.
#
class rsyslog::service {

  service { 'rsyslog':
    name       => $::rsyslog::service_name,
    ensure     => $::rsyslog::service_ensure,
    enable     => $::rsyslog::service_ensure ? {
      'running' => true,
      'stopped' => false,
    },
    hasstatus  => true,
    hasrestart => true,
  }
}
