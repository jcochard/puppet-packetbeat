# packetbeat comments
class packetbeat::config {

  $notify_service = $packetbeat::restart_on_change ? {
    true  => Class['packetbeat::service'],
    false => undef,
  }

  if ( $packetbeat::ensure == 'present' ) {

    file { $packetbeat::conf_dir:
      ensure  => directory,
      purge   => $packetbeat::purge_configdir,
      recurse => $packetbeat::purge_configdir,
    }

    file_concat { 'pb_config':
      ensure  => 'present',
      tag     => "PB_CONFIG_${::fqdn}",
      path    => $packetbeat::config,
      owner   => $packetbeat::packetbeat_user,
      group   => $packetbeat::packetbeat_group,
      mode    => '0600',
      notify  => $notify_service,
      require => File[$packetbeat::conf_dir],
    }
  }
  elsif ( $packetbeat::ensure == 'absent' ) {
    file { $packetbeat::conf_dir:
      ensure  => 'absent',
      recurse => true,
      force   => true,
    }
  }

}
