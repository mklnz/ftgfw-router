#!/bin/sh

# Partition usb drive
umount /dev/sda?
echo -e "o\nn\np\n1\n\n+500M\nw" | fdisk /dev/sda
umount /dev/sda?
mkfs.ext3 -L ENTWARE /dev/sda1

echo "LABEL=ENTWARE /opt ext3 rw,noatime 1 1" >> /etc/fstab

# Install entware
mount /opt
entware-install.sh

# Install packages
opkg update
opkg install bash vim openssh-sftp-server ruby ruby-enc-extra \
ruby-net ruby-openssl ruby-optparse ruby-yaml git git-http ca-certificates shadowsocks-libev

# Config
git clone https://github.com/mklnz/ftgfw-router.git /opt/ftgfw-router

nvram set script_usbmount='/opt/ftgfw-router/usb_mount.sh'
nvram set script_usbumount='/opt/ftgfw-router/usb_unmount.sh'
nvram set script_init='echo "LABEL=ENTWARE /opt ext3 rw,noatime 1 1" >> /etc/fstab'
nvram set script_fire='/opt/ftgfw-router/firewall.sh'
nvram set script_wanup='/opt/ftgfw-router/wan_up.sh'
nvram set dnsmasq_custom='strict-order
conf-dir=/opt/ftgfw-router/gfwlist2dnsmasq/dnsmasq.d'

nvram commit

# Done!
echo 'Installation complete, rebooting...'
reboot