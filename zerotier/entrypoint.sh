#!/bin/sh

ZT_JOIN_STATUS="NOK"
ZT_STATUS="OFFLINE"

echo "Start ZeroTier Daemon"
zerotier-one -d
sleep 10 # not cool
zerotier-cli info

echo "Joining netwok ${ZT_NW_ID}"
ZT_JOIN_STATUS=$(echo $(zerotier-cli join ${ZT_NW_ID} | awk '{print $3}'))

if [ "$ZT_JOIN_STATUS" = "OK" ]; then 
    echo "Join successful." 
    ZT_STATUS="ONLINE"
else
    echo "Join unsuccessful. Exit." 
    exit 1
fi;

while [ "$ZT_STATUS" = "ONLINE" ]
do
    ZT_STATUS=$(echo $(zerotier-cli info) | awk '{print $5}')
	sleep 5
done