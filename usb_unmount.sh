#!/bin/sh
/opt/etc/init.d/rc.unslung stop
sleep 15
for i in `cat /proc/mounts | awk '/ext3/{print($1)}'` ; do
  mount -o remount,ro $i
done
