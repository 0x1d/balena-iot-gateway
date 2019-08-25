#!/bin/bash

zerotier-one &
zerotier-cli info
zerotier-cli join ${ZT_NW_ID}