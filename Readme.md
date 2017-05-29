Packetbeat module for Uber
Jason Cochard (jasonc@uber.com)
05/19/2017

Protocols are dynamically generated off of hash values in hiera
e.g. from hiera:
```
packetbeat::protocols_enabled:
 dns:
   ports: "[53]"
   include_authorities: true
   include_additionals: true
 icmp:
```
creates a section in packetbeat.yml:
```
packetbeat.protocol.dns:
 enabled: true
 ports: [53]
 include_authorities: true
 include_additionals: true
packetbeat.protocol.icmp:
 enabled: true
```
