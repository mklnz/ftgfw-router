#!/bin/sh
CONFIG=/opt/ftgfw-router/config/shadowsocks.json
DNS=8.8.8.8:53
TUNNEL_PORT=5353

/opt/bin/ss-redir -c $CONFIG -b 0.0.0.0 -f /opt/tmp/ss-redir.pid
/opt/bin/ss-tunnel -c $CONFIG -b 0.0.0.0 -u -l $TUNNEL_PORT -L $DNS -f /opt/tmp/ss-tunnel.pid
