#!/bin/bash -eux

# Remove items used for building, since they aren't needed anymore
echo "removing unnessary packages"
apt-get -y remove linux-headers-$(uname -r) build-essential
apt-get -y autoremove

# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
rm /var/lib/dhcp/*

echo "cleaning apt cache"
apt-get clean

echo "cleaning gem cache"
rm /var/lib/gems/1.9.1/cache/*

echo "cleaning tmp cache"
rm -f /tmp/chef*deb

# Make sure Udev doesn't block our network
# http://6.ptmc.org/?p=164
echo "cleaning up udev rules"
rm /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

echo "Adding a 2 sec delay to the interface up, to make the dhclient happy"
echo "pre-up sleep 2" >> /etc/network/interfaces
