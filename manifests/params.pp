# packetbeat params for various OS's
class packetbeat::params {

  $conf_dir         = '/etc/packetbeat'
  $ensure           = 'present'
  $packetbeat_user  = 'root'
  $packetbeat_owner = 'root'

  case $facts['os']['family'] {
    'RedHat': {
      $supported  = true
      $version    = '5.4.0'
      $libpcap    = 'libpcap'
      $package    = "packetbeat-${version}"
      $service    = 'packetbeat'
      $config     = '/etc/packetbeat/packetbeat.yml'
    }
    'Debian': {
      $supported  = true
      $version    = '5.4.0'
      $libpcap    = 'libpcap0.8'
      $package    = 'packetbeat'
      $service    = 'packetbeat'
      $config     = '/etc/packetbeat/packetbeat.yml'
    }
    default: {
      $supported = false
      notify { "${module_name}_unsupported" :
        message => "The ${module_name} module is not support on ${::operatingsystem}",
      }
    }
  }
}
