FROM nodered/node-red-docker:0.20.5-10-slim-arm32v7	

# installing an editor
#USER root
#RUN apt-get update && apt-get install -y nano curl

USER node-red
COPY ./package.json .
COPY ./settings.js /data/settings.js
COPY ./flows.json /data/flows.json

RUN npm install