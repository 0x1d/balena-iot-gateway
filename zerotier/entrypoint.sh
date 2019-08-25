#!/bin/bash

echo "Start ZeroTier Daemon"
touch /var/lib/zerotier-one/networks.d/${ZT_NW_ID}.conf
zerotier-one