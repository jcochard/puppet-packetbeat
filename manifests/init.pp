# Module for installing packetbeat on CentOS/Debian-like systems
class packetbeat (
  $ensure           = 'running',
  $enable           = true,
  $package          = $packetbeat::params::package,
  $packetbeat_user  = $packetbeat::params::user,
  $packetbeat_owner = $packetbeat::params::owner,
  $service          = $packetbeat::params::service,
  $config           = $packetbeat::params::config,
  $version          = $packetbeat::params::version,

  ) inherits packetbeat::params {

  include stdlib

  if $packetbeat::params::supported == true {
    anchor { 'packetbeat::start':}->
    class  { 'packetbeat::package':}~>
    class  { 'packetbeat::config':}~>
    class  { 'packetbeat::service':}~>
    anchor { 'packetbeat::end':}
  }
}
