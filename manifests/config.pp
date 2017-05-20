# packetbeat comments
class packetbeat::config {

  $es_vip      = $packetbeat::es_vip
  $es_port     = $packetbeat::es_port
  $es_password = $packetbeat::es_password
  $es_username = $packetbeat::es_username

  notify{ "es_vip is: ${es_vip}": }

  file { $packetbeat::config:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${packetbeat::template}"),
  }
}
