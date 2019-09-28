FROM nodered/node-red-docker:latest

# installing an editor
#USER root
#RUN apt-get update && apt-get install -y nano curl


USER node-red

RUN npm install
#COPY ./package.json .

COPY ./settings.js /data/settings.js
COPY ./flows.json /data/flows.json