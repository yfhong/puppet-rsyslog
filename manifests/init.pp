# == Class: rsyslog
#
# Full description of class rsyslog here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class rsyslog (
  $package_name   = $::rsyslog::params::package_name,
  $package_ensure = $::rsyslog::params::package_ensure,
  $service_name   = $::rsyslog::params::service_name,
  $service_ensure = $::rsyslog::params::service_ensure,
  $conffile       = $::rsyslog::params::conffile,
  $use_tcp        = $::rsyslog::params::use_tcp,
  $use_udp        = $::rsyslog::params::use_udp,
  $listen_address = $::rsyslog::params::listen_address,
  $logdir         = $::rsyslog::params::logdir,
) inherits ::rsyslog::params {

  # validate parameters here

  class { '::rsyslog::install': } ->
  class { '::rsyslog::config': } ~>
  class { '::rsyslog::service': } ->
  Class['::rsyslog']
}
