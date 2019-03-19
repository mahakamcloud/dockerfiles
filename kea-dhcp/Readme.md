### Version

Kea DHCP version 1.5.0 on Ubuntu 18.04(Bionic)

### How to Build:

  1. Build `builder` image:
     `docker build --target builder -t kea-dhcp-builder .`
  2. Build `kea-dhcp` image:
     `docker build --target kea-dhcp -t kea-dhcp .`
  3. Build `kea-dhcp-postgres` image:
     `docker build --target kea-dhcp-postgres -t kea-dhcp-postgres .`
