class packetbeat::package {

  package { $packetbeat::package:
    ensure  => $packetbeat::version,
    source  => "/root/$packetbeat::package",
  }

  package { $packetbeat::params::libpcap:
    ensure => 'installed',
  }
}
