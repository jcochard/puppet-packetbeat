# Module for installing packetbeat on CentOS/Debian-like systems
class packetbeat (
  $ensure            = $packetbeat::params::ensure,
  $enable            = true,
  $package           = $packetbeat::params::package,
  $packetbeat_user   = $packetbeat::params::user,
  $packetbeat_group  = $packetbeat::params::group,
  $purge_configdir   = true,
  $restart_on_change = true,
  $service           = $packetbeat::params::service,
  $config            = $packetbeat::params::config,
  $conf_dir          = $packetbeat::params::conf_dir,
  $version           = $packetbeat::params::version,

  ) inherits packetbeat::params {

  include stdlib

  # ensure
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail("\"${ensure}\" is not a valid ensure parameter value")
  }

  if $packetbeat::params::supported == true {
    anchor { 'packetbeat::start':}->
    class  { 'packetbeat::package':}~>
    class  { 'packetbeat::config':}~>
    class  { 'packetbeat::service':}~>
    anchor { 'packetbeat::end':}
  }
}
