#!/bin/sh

# FIXME this should be started background through an init system
echo "Start ZeroTier Daemon"
nohup zerotier-one -d
sleep 10
zerotier-cli info

echo "Joining netwok ${ZT_NW_ID}"
zerotier-cli join ${ZT_NW_ID}