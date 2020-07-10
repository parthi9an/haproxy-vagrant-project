#!/bin/bash

if [ ! -f /etc/haproxy/haproxy.cfg ]; then

  # Install haproxy # 
  /usr/bin/apt-get update && /usr/bin/apt-get -y install haproxy

  # Configure haproxy
  cat > /etc/default/haproxy <<EOD
# Set ENABLED to 1 if you want the init script to start haproxy.
ENABLED=1
# Add extra flags here.
#EXTRAOPTS="-de -m 16"
EOD
  cat > /etc/haproxy/haproxy.cfg <<EOD
global
    daemon
    maxconn 256

defaults
    mode http
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

frontend http-in
    bind *:80
    default_backend webservers

backend webservers
    # load balancer roundrobin method
    balance roundrobin
    # Sticky session
    cookie SRVNAME insert
    option httpchk
    option forwardfor
    option http-server-close
    server web1 192.168.56.11:80 cookie W1 maxconn 32 check inter 5000 fall 5 rise 1
    server web2 192.168.56.12:80 cookie W2 maxconn 32 check inter 5000 fall 5 rise 1

listen admin
    bind *:8080
    stats enable
EOD

  cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.orig
  /usr/sbin/service haproxy restart
fi