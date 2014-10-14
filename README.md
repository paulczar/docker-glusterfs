

Does not work with `aufs` docker needs to be running in `btrfs` mode.

```
$ /usr/bin/docker run -t -i --cap-add=SYS_ADMIN \
 -p 111:111 -p 24007:24007 -p 2049:2049 \
 -p 38465:38465 -p 38466:38466 -p 38467:38467 \
 -p 1110:1110 -p 4045:4045 -e PUBLISH=24007 \
 -e EXPECTED_MEMBERS=2 -e DEBUG=1 \
 -e HOST=$COREOS_PRIVATE_IPV4 paulczar/glusterfs:latest bash

 $ bin/boot
```
