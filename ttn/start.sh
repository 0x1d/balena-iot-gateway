#!/bin/bash

echo "reset LGW on pin ${GW_RESET_PIN}"
/opt/ttn-gateway/reset_lgw.sh stop ${GW_RESET_PIN}
/opt/ttn-gateway/reset_lgw.sh start $GW_RESET_PIN

python /opt/ttn-gateway/run.py
