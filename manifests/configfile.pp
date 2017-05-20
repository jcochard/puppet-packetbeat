# Definied type to manage configs in puppet-control rather than the module
# Can define content directly, or from a puppet source, or a template
define packetbeat::configfile (
  $content  = undef,
  $source   = undef,
  $template = undef,
) {

  if ($template != undef ) {
    $config_content = template($template)
  }
  elsif ($content != undef) {
    $config_content = $content
  }

  file_fragment { $name:
    content => $config_content,
    tag     => "PB_CONFIG_${::fqdn}",
    source  => $source,
    before  => File[$packetbeat::config]
  }

}
