# Definied type to manage configs in puppet-control rather than the module
# Can define content directly, or from a puppet source, or a template
define packetbeat::configfile (
  $content = undef,
  $source  = undef,
  $template = undef,
) {

  if ($template != undef ) {
    $config_content = template($template)
  }
  elsif ($content != undef) {
    $config_content = $content
  }

  file { $name:
    content => $config_content,
    source  => $source,
    owner   => $packetbeat::packetbeat_user,
    group   => $packetbeat::packetbeat_group,
  }

  }
