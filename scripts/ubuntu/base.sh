#!/bin/bash -eux

# Apt-install various things necessary for Ruby, guest additions,
# etc., and remove optional things to trim down the machine.

# Compress apt indexes
cat <<EOF > /etc/apt/apt.conf.d/02compress-indexes
Acquire::GzipIndexes "true";
Acquire::CompressionTypes::Order:: "gz";
EOF

apt-get -y update
apt-get -y upgrade
apt-get -y install linux-headers-$(uname -r) build-essential
apt-get -y install zlib1g-dev libssl-dev libreadline-gplv2-dev libyaml-dev
apt-get -y install vim

# Install NFS client
apt-get -y install nfs-common

# Without libdbus virtualbox would not start automatically after compile
apt-get -y install --no-install-recommends libdbus-1-3
apt-get -y install dkms
