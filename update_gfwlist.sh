#!/bin/sh

/opt/ftgfw-router/gfwlist2dnsmasq-rb/gfwlist2dnsmasq.rb
service dnsmasq restart
