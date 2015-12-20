#!/bin/sh

iptables -t nat -A PREROUTING -p tcp -m set --set gfwlist dst -j REDIRECT --to-port 1080
