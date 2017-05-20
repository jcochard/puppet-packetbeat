# packetbeat service management
class packetbeat::service {
  service { $packetbeat::params::service:
    ensure => $packetbeat::ensure,
    enable => $packetbeat::enable,
  }
}
