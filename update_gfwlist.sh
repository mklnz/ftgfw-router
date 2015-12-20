#!/bin/sh
/opt/ftgfw-router/gfwlist2dnsmasq-rb/gfwlist2dnsmasq.rb -c /opt/ftgfw-router/config/gfwlist2dnsmasq-rb.yml
service dnsmasq restart
