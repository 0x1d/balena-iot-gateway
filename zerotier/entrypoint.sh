#!/bin/bash

echo "Start ZeroTier Daemon"
zerotier-one &
zerotier-cli info
echo "Join netwok ${ZT_NW_ID}"
zerotier-cli join ${ZT_NW_ID}