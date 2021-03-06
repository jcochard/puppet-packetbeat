# Installs the packetbeat package based on OS
class packetbeat::package {

  package { $packetbeat::package:
    ensure => $::packetbeat::version,
  }

  package { $packetbeat::params::libpcap:
    ensure => 'installed',
  }
}
