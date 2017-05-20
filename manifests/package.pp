# Installs the packetbeat package based on OS
class packetbeat::package {

  package { $packetbeat::package:
    ensure => 'installed',
  }

  package { $packetbeat::params::libpcap:
    ensure => 'installed',
  }
}
