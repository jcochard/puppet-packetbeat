class packetbeat::package {

  package { $packetbeat::package:
    ensure   => 'installed',
    provider => 'rpm',
    source   => "/root/$packetbeat::package",
  }

  package { $packetbeat::params::libpcap:
    ensure => 'installed',
  }
}
