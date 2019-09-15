#!/usr/bin/env bash
#echo $HOME/go

osb=$HOME/go/src/github.com/kata-containers/packaging
mkdir -p $osb
cp -rv * $osb
pushd $osb/kernel
./build-kernel.sh setup
./build-kernel.sh build
./build-kernel.sh install
#ROOTFS_DIR=$osb/rootfs GOPATH=$HOME/go AGENT_INIT=yes USE_DOCKER=yes  SECCOMP=yes ./rootfs-builder/rootfs.sh alpine
#cd image-builder
#USE_DOCKER=true ./image_builder.sh $osb/rootfs
#install -o root -g root -m 0640 -D kata-containers.img "/usr/share/kata-containers/kata-containers.img"
