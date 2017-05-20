# packetbeat service management
class packetbeat::service {
  service { $packetbeat::params::service:
    ensure => $packetbeat::status,
    enable => $packetbeat::enable,
  }
}
