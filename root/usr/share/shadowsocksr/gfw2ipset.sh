#!/bin/sh

mkdir -p /tmp/dnsmasq.ssr
fwd_port=${1:-5335}
awk '!/^$/&&!/^#/{printf("ipset=/.%s/'"gfwlist"'\n",$0)}' /etc/ssr/gfw.list > /tmp/dnsmasq.ssr/custom_forward.conf
awk '!/^$/&&!/^#/{printf("server=/.%s/'"127.0.0.1#'${fwd_port}'"'\n",$0)}' /etc/ssr/gfw.list >> /tmp/dnsmasq.ssr/custom_forward.conf

awk '!/^$/&&!/^#/{printf("ipset=/.%s/'"blacklist"'\n",$0)}' /etc/ssr/black.list > /tmp/dnsmasq.ssr/blacklist_forward.conf
awk '!/^$/&&!/^#/{printf("server=/.%s/'"127.0.0.1#'${fwd_port}'"'\n",$0)}' /etc/ssr/black.list >> /tmp/dnsmasq.ssr/blacklist_forward.conf

awk '!/^$/&&!/^#/{printf("ipset=/.%s/'"whitelist"'\n",$0)}' /etc/ssr/white.list > /tmp/dnsmasq.ssr/whitelist_forward.conf

