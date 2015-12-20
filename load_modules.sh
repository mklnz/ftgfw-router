#!/bin/sh

# Loading ipset modules
modprobe ipt_set

ipset -N gfwlist iphash
