# Module for installing packetbeat on CentOS/Debian-like systems
class packetbeat (
  $config            = $packetbeat::params::config,
  $conf_dir          = $packetbeat::params::conf_dir,
  $ensure            = $packetbeat::params::ensure,
  $enable            = true,
  $package           = $packetbeat::params::package,
  $packetbeat_user   = $packetbeat::params::user,
  $packetbeat_group  = $packetbeat::params::group,
  $restart_on_change = true,
  $service           = $packetbeat::params::service,
  $status            = $packetbeat::params::status,
  $version           = $packetbeat::params::version,

  ) inherits packetbeat::params {

  include stdlib

  anchor {'packetbeat::begin': }
  anchor {'packetbeat::end': }

  # Validate parameters
  # ensure
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail("\"${ensure}\" is not a valid ensure parameter value")
  }
  # service status
  if ! ($status in [ 'enabled', 'disabled', 'running', 'unmanaged' ]) {
    fail("\"${status}\" is not a valid status parameter value")
  }
  # restart on change
  validate_bool($restart_on_change)

  # Call other classes
  class { 'packetbeat::package': }
  class { 'packetbeat::config': }
  class { 'packetbeat::service': }

  # Manage relationships
  if $ensure == 'present' {

    # we need the software before configuring it
    Anchor['packetbeat::begin']
    -> Class['packetbeat::package']
    -> Class['packetbeat::config']

    # we need the software and a working configuration before running a service
    Class['packetbeat::package'] -> Class['packetbeat::service']
    Class['packetbeat::config']  -> Class['packetbeat::service']

    Class['packetbeat::service'] -> Anchor['packetbeat::end']

  } else {

    # make sure all services are getting stopped before software removal
    Anchor['packetbeat::begin']
    -> Class['packetbeat::service']
    -> Class['packetbeat::package']
    -> Anchor['packetbeat::end']

  }
}
