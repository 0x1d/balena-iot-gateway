FROM nodered/node-red:1.0.1-10-arm32v7

# installing an editor
#USER root
#RUN apt-get update && apt-get install -y nano curl

USER node-red

RUN npm install node-red-contrib-resinio \
    node-red-contrib-credentials \
    node-red-contrib-moment \
    node-red-contrib-config \
    node-red-contrib-fs-ops \
    node-red-contrib-http-multipart \
    node-red-contrib-md5 \
    node-red-contrib-ui_list \
    node-red-dashboard


COPY ./settings.js /data/settings.js
COPY ./flows.json /data/flows.json