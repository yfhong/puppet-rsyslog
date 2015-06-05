# == Class rsyslog::config
#
# This class is called from rsyslog for service config.
#
class rsyslog::config {

  $udp_enabled = $::rsyslog::use_udp
  $tcp_enabled = $::rsyslog::use_tcp
  $listen_address = $::rsyslog::listen_address

  $logdir = $::rsyslog::logdir
  $local_rules = hiera_array('rsyslog::local_rules')

  file { $::rsyslog::logdir:
    ensure => 'directory',
    owner  => 'root',
    group  => $::rsyslog::params::root_group,
    mode   => '0755',
  }

  file { $::rsyslog::conffile:
    ensure  => 'present',
    owner   => 'root',
    group   => $::rsyslog::params::root_group,
    mode    => '0640',
    content => template('rsyslog/rsyslog.conf.erb'),
  }
}
