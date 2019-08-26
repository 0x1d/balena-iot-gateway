#!/bin/bash

# FIXME this should be started background through an init system
echo "Start ZeroTier Daemon"
zerotier-one -d
sleep 10
zerotier-cli info

echo "Join netwok ${ZT_NW_ID}"
zerotier-cli join ${ZT_NW_ID}