

Does not work with `aufs` docker needs to be running in `btrfs` mode.

```
$ export COREOS_PRIVATE_IPV4=172.17.8.101
$ /usr/bin/docker run -t -i --cap-add=SYS_ADMIN \
 -p 111:111 -p 24007:24007 -p 2049:2049 \
 -p 38465:38465 -p 38466:38466 -p 38467:38467 \
 -p 49152:49152 -p 49153:49153 -p 49154:49154 \
 -p 1110:1110 -p 4045:4045 -e PUBLISH=24007 \
 -e EXPECTED_MEMBERS=2 -e DEBUG=1 \
 -e HOST=$COREOS_PRIVATE_IPV4 paulczar/glusterfs:latest
```

Test
===

```
/usr/bin/docker run -t -i --cap-add=SYS_ADMIN paulczar/glusterfs:latest bash
service rpcbind start
mkdir -p /mnt/vol11
mkdir -p /mnt/vol12
mount -o mountproto=tcp -t nfs 172.17.8.101:/vol1 /mnt/vol11
mount -o mountproto=tcp -t nfs 172.17.8.102:/vol1 /mnt/vol12
echo hello > /mnt/vol11/bacon

```

confd -verbose -debug -onetime -node $HOST:4001 -config-file /app/confd.toml



/usr/bin/docker run -d --cap-add=SYS_ADMIN \
 -p 111:111 -p 24007:24007 -p 24009:24009 \
 -p 38465:38465 -p 38466:38466 -p 38467:38467 \
 -p 38468:38468 -p 48759:48759 \
 -p 49152:49152 -p 49153:49153 -p 49154:49154 \
 -p 1110:1110 -p 4045:4045 -e PUBLISH=24007 \
 -e EXPECTED_MEMBERS=2 \
 -e HOST=$COREOS_PRIVATE_IPV4 paulczar/glusterfs:latest


 /usr/bin/docker run -d --cap-add=SYS_ADMIN \
          --name glusterfs -e EXPECTED_MEMBERS=2 \
          -p 111:111 -p 24007:24007 -p 24009:24009 \
          -p 38465:38465 -p 38466:38466 -p 38467:38467 \
          -p 38468:38468 -p 48759:48759 \
          -p 49152:49152 -p 49153:49153 -p 49154:49154 \
          -p 1110:1110 -p 4045:4045 -e PUBLISH=24007 \
          -e HOST=$COREOS_PRIVATE_IPV4 paulczar/glusterfs:latest bin/boot