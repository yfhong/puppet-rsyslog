# == Class rsyslog::config
#
# This class is called from rsyslog for service config.
#
class rsyslog::config {

  file { $::rsyslog::logdir:
    ensure => 'directory',
    owner  => 'root',
    group  => $::rsyslog::params::root_group,
    mode   => '0755',
  }

  file { $::rsyslog::conffile:
    ensure => 'present',
    owner  => 'root',
    group  => $::rsyslog::params::root_group,
    mode   => '0640',
  }

  if ($::rsyslog::use_udp) {
    file_line { 'load_udp_mode':
      path  => $::rsyslog::conffile,
      line  => '\$ModLoad imudp',
      match => ".*ModLoad\s+imudp.*",
    }

    file_line { 'set_udp_port':
      path  => $::rsyslog::conffile,
      line  => '\$UDPServerRun 514',
      match => "[#\s]*\$UDPServerRun.*",
    }

    file_line { 'set_udp_bind_address':
      path  => $::rsyslog::conffile,
      line  => "\$UDPServerAddress ${::rsyslog::listen_address}",
      match => ".*UDPServerAddress.*",
      after => '\$UDPServerRun 514',
    }
  }

  if ($::rsyslog::use_tcp) {
    file_line { 'load_tcp_mode':
      path  => $::rsyslog::conffile,
      line  => '\$ModLoad imtcp',
      match => ".*ModLoad\s+imtcp.*",
    }

    file_line { 'set_tcp_port':
      path  => $::rsyslog::conffile,
      line  => '\$TCPServerRun 514',
      match => "[#\s]*\$TCPServerRun.*",
    }

    file_line { 'set_tcp_bind_address':
      path  => $::rsyslog::conffile,
      line  => "\$TCPServerAddress ${::rsyslog::listen_address}",
      match => ".*TCPServerAddress.*",
      after => '\$TCPServerRun 514',
    }
  }
}
