#!/bin/sh

echo "Start ZeroTier Daemon"
zerotier-one -d
sleep 10 # not cool
zerotier-cli info

echo "Joining netwok ${ZT_NW_ID}"
ZT_STATUS=$(echo $(zerotier-cli join ${ZT_NW_ID} | awk '{print $3}'))

if [ "$ZT_STATUS" = "OK" ]; then 
    echo "Join successful." 
else
    echo "Join unsuccessful. Exit." 
    exit 0
fi;

while ((  ZT_STATUS == 'ONLINE' ))
do
    ZT_STATUS=$(echo $(zerotier-cli info) | awk '{print $5}')
	sleep 5
done