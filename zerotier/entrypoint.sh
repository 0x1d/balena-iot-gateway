#!/bin/bash

echo "Start ZeroTier Daemon"
mkdir -p /var/lib/zerotier-one/networks.d
touch /var/lib/zerotier-one/networks.d/${ZT_NW_ID}.conf
zerotier-one