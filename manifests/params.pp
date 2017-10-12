# packetbeat params for various OS's
class packetbeat::params {

  $conf_dir = '/etc/packetbeat'
  $config   = '/etc/packetbeat/packetbeat.yml'
  $ensure   = 'present'
  $group    = 'root'
  $package  = 'packetbeat'
  $status   = 'running'
  $service  = 'packetbeat'
  $user     = 'root'
  $version  = '5.4.0'

  case $facts['os']['family'] {
    'RedHat': {
      $supported  = true
      $libpcap    = 'libpcap'
    }
    'Debian': {
      $supported  = true
      $libpcap    = 'libpcap0.8'
    }
    default: {
      $supported = false
      notify { "${module_name}_unsupported" :
        message => "The ${module_name} module is not support on ${::operatingsystem}",
      }
    }
  }
}
