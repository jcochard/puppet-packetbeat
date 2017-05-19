# packetbeat comments
class packetbeat::config {

  $es_vip  = $packetbeat::es_vip
  $es_port = $packetbeat::es_port

  file { $packetbeat::config:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${packetbeat::template}"),
  }
}
