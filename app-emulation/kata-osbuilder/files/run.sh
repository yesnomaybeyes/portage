#!/usr/bin/env bash
#echo $HOME/go

osb=$HOME/go/src/github.com/kata-containers/osbuilder
mkdir -p $osb
cp -rv * $osb
pushd $osb
rm -rvf $osb/rootfs
ROOTFS_DIR=$osb/rootfs GOPATH=$HOME/go AGENT_INIT=yes USE_DOCKER=yes  SECCOMP=yes ./rootfs-builder/rootfs.sh fedora
cd image-builder
SECCOMP=yes USE_DOCKER=true ./image_builder.sh $osb/rootfs
install -o root -g root -m 0640 -D kata-containers.img "/usr/share/kata-containers/kata-containers.img"
cd ../initrd-builder
AGENT_INIT=yes USE_DOCKER=true ./initrd_builder.sh $osb/rootfs
install -o root -g root -m 0640 -D kata-containers-initrd.img "/usr/share/kata-containers/kata-containers-initrd.img"
