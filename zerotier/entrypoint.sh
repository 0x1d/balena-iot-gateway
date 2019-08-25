#!/bin/bash

/usr/sbin/zerotier-one &
/var/lib/zerotier-one/zerotier-cli info
/var/lib/zerotier-one/zerotier-cli join ${ZT_NW_ID}