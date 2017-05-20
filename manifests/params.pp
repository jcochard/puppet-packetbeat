# packetbeat comments
class packetbeat::params {
  case $facts['os']['family'] {
    'RedHat': {
      $supported  = true
      $version    = '5.4.0'
      $package    = "packetbeat-${version}-x86_64"
      $libpcap    = 'libpcap'
      $service    = 'packetbeat'
      $config     = '/etc/packetbeat/packetbeat.yml'
    }
    'Debian': {
      $supported  = true
      $version    = '5.4.0'
      $libpcap    = 'libpcap0.8'
      $package    = "packetbeat-${version}-amd64"
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
