Packetbeat module  
Jason Cochard (jasonc@uber.com)  
05/19/2017  

Taken with the defaults, this module will install packetbeat on CentOS or  
Debian-like systems. It assumes that the .rpm or .deb is available to your  
machine in a corresponding yum or apt repo.  

If the default config is set to false, you can supply a template by directly adding  
packetbeat::configfile to your manifest, e.g.:  
```
packetbeat::configfile { 'packetbeat_config':
  content => template("site/profile/packetbeat/packetbeat.yml.erb"),
  order   => '10',
}
```

We also support dynamically building the config with hashes, broken into three  
sections. You will need to supply a config_hash,  outputs_hash, and protocols_hash  
to generate a config. Example of each here in hiera.  Some of these are hashes of  
hashes, while some values are just hashes.  
  
config_hash:  
```
packetbeat::config_hash:
  packetbeat.interfaces.device: 'any'
  packetbeat.flows:
    enabled: 'true'
    timeout: '30s'
    period: '10s'
  packetbeat.interfaces.snaplen: '1500'
  logging.to_files: 'true'
  logging.files:
    path: '/var/log/packetbeat'
    name: 'packetbeat.log'
```
outputs_hash:  
```
packetbeat::outputs_hash:
  elasticsearch:
    hosts: "[\"%{hiera('packetbeat::ece-endpoint')}:%{hiera('packetbeat::ece-port')}\"]"
    protocol: 'https'
    username: 'packetbeat'
    password: "%{hiera('packetbeat::ece_password')}"
```

protocols_hash:  
```
packetbeat::protocols_enabled:
 dns:
   ports: "[53]"
   include_authorities: true
   include_additionals: true
 icmp:
```
