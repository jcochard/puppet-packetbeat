# Module for installing packetbeat on CentOS/Debian-like systems
class packetbeat ( $package  = $packetbeat::params::package,
                   $service  = $packetbeat::params::service,
                   $config   = $packetbeat::params::config,
                   $version  = $packetbeat::params::version,
                   $ensure   = 'running',
                   $enable   = true,
                   $es_vip   = undef,
                   $es_port  = undef,
                   $template = "${module_name}/packetbeat.yml.erb"

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
