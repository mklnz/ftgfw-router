#!/bin/sh

# Partition usb drive
echo "LABEL=ENTWARE /opt ext3 rw,noatime 1 1" >> /etc/fstab
umount /dev/sda?
echo -e "o\nn\np\n1\n\n+500M\nw" | fdisk /dev/sda
umount /dev/sda?
mkfs.ext3 -L ENTWARE /dev/sda1
sleep 2
umount /dev/sda?
mount /opt

# Install entware
wget -O - http://pkg.entware.net/binaries/mipsel/installer/installer.sh | sh

# Install packages
opkg update
opkg install bash vim openssh-sftp-server bind-dig ruby ruby-enc-extra \
ruby-net ruby-openssl ruby-optparse ruby-yaml perl git git-http ca-certificates shadowsocks-libev

# Config
git clone --recursive https://github.com/mklnz/ftgfw-router.git /opt/ftgfw-router

nvram set script_usbmount='/opt/ftgfw-router/usb_mount.sh'
nvram set script_usbumount='/opt/ftgfw-router/usb_unmount.sh'
nvram set script_init='echo "LABEL=ENTWARE /opt ext3 rw,noatime 1 1" >> /etc/fstab'
nvram set script_fire='/opt/ftgfw-router/firewall.sh'
nvram set script_wanup='/opt/ftgfw-router/wan_up.sh'
nvram set dnsmasq_custom='strict-order
conf-dir=/opt/ftgfw-router/gfwlist2dnsmasq-rb/dnsmasq.d'
nvram commit

# Update gfwlist2dnsmasq-rb
/opt/ftgfw-router/update_gfwlist.sh

# Done!
echo 'Installation complete, rebooting...'
reboot
