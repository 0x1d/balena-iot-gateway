FROM nodered/node-red-docker:rpi-v10

# installing an editor
USER root
RUN apt-get update && apt-get install nano
USER node-red

RUN npm install 
RUN npm install node-red-dashboard
RUN npm install node-red-contrib-credentials

RUN npm install \
    node-red-contrib-resinio \
    node-red-contrib-credentials \
    node-red-contrib-moment \
    node-red-contrib-config \
    node-red-contrib-fs-ops \
    node-red-contrib-http-multipart \
    node-red-contrib-md5 \
    node-red-contrib-ui_list \
    node-red-contrib-ui_button \
    node-red-dashboard 


COPY ./settings.js /data/settings.js
COPY ./flows.json /data/flows.json