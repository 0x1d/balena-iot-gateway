[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/janvda/balena-node-red-mqtt-nginx-TIG-stack) 

# Composite docker application with Node-RED, MQTT broker, Telegraf, InfluxDb, Grafana, Nginx) deployed on Raspberry Pi through [Balena](https://www.balena.io).

IoT gateway based on [balena-node-red-mqtt-nginx-TIG-stack](https://github.com/janvda/balena-node-red-mqtt-nginx-TIG-stack).  
To reduce resource demands, the additional Node-RED and MQTT broker test instances have been removed.  

## Features
This project is a proof of concept to demonstrate the following features:
1. Multi container application using the **BalenaCloud** services (see [section 2. How to install ...](#2-how-to-install-this-application-on-an-edge-device))
1. Monitoring the system resources of the raspberry pi using the **TIG** stack (see [section 3. System resource monitoring ...](#3-system-resource-monitoring-using-the-tig-stack-telegraf-influxdb--grafana))
1. Grafana dashboards  (see [section 4. Grafana](#4-grafana)).
1. Node-RED for device integration (see [section 5. Node-RED](#5-node-red)).
1. Mosquitto as local message bus (see [section 6. MQTT brokers](#6-mqtt-broker)).
1. USB memory stick connected to the pi can be used for storing specific data (in this case it is the influxdb data) (see [section 7. USB memory stick](#7-setup-of-the-usb-memory-stick-for-influxdb)).

## 1. What
1. [Telegraf](https://www.influxdata.com/time-series-platform/telegraf/) - agent for collecting and reporting metrics and events
2. [Influxdb](https://www.influxdata.com/) - Time Series Database
3. [Grafana](https://grafana.com/) - create, explore and share dashboards
4. [Node-RED](https://nodered.org/) - flow based programming for the Internet of Things (accessible through path `/nodered` )
5. [MQTT-broker](https://mosquitto.org/) - lightweight message broker
4. [nginx](http://nginx.org/en/docs/) - is open source software for web serving, reverse proxying, caching, load balancing,....


## 2. How to install this application on an edge device
It is very easy to install this application using the [BalenaCloud](https://www.balena.io/) services through following steps:
1. [Balena Setup](https://www.balena.io/): you need a BalenaCloud account and your edge device must be running the BalenaOs.  You also need to create an application in your balena dashboard and associate your edge device to it (see balena documentation).
2. clone this github repository (this can be done on any device where git is installed) through the following command `git clone https://github.com/janvda/balena-node-red-mqtt-nginx-TIG-stack.git` (instead of directly cloning the repository it migh be better to fork the github repository and then clone this forked repository).
3. Move into this repository by command `cd balena-edge-device-monitoring`
4. Add balena git remote endpoint by running a command like `git remote add balena <USERNAME>@git.www.balena.io:<USERNAME>/<APPNAME>.git`
5. push the repository to balena by the command `git push balena master` (maybe you need to add the option `--force` the first time you are deploying).

![build finished successful](./build%20finished%20successful.png)

## 3. System resource monitoring using the TIG Stack (Telegraf, Influxdb & Grafana)
The system resource monitoring is realized by the TIG stack and happens as follows:
1. The [Telegraf](https://www.influxdata.com/time-series-platform/telegraf/) container collects the system resource metrics (memory, CPU, disk, network, ...) of the raspberry pi device and sends them to 
2. the [Influxdb](https://www.influxdata.com/) container that will store them in the influx database.  
3. The [Grafana](https://grafana.com/) container has a dashboard (see screenshot below) showing these system metrics that it has retrieved from the influxdb.

## 3.1 Telegraf
The table below specifies the environment variables that can be set in the Balena Device Service Variables panel for the Telegraf Service.  Note that the `Default Value` is defined in `docker-compose.yml`

| Name                     | Default Value  |  Description                                    |
|------------------------- | -------------- |-------------------------------------------------|
| **interval**             |    `60s`       | Frequency at which metrics are collected        |
| **flush_interval**       |    `60s`       | Flushing interval (should not set < `interval`) |

## 4. Grafana
The [Grafana](https://grafana.com/) user interface can be accessed at port 3000 of the host OS.
The login and password is `admin`.
The name of the dashboard is `system metrics`.

Here below a screenshot of the `system metrics` dashboard that is also provisioned by this application ( file is `grafana\dashboards\system metrics.json`)

![system metrics example top part](./system_metrics_dashboard_1_of_2.png)
![system metrics example bottom part](./system_metrics_dashboard_2_of_2.png)

## 4.1. Updating / Adding new Grafana Dashboards

If you want to add a new Grafana dashboard then this can be done through following steps (Updating an existing dashboard can be done in a similar way):

1. Create the new dashboard using the Grafana UI.
2. From the settings menu in Grafana UI select `View JSON` and copy the complete json file (**don't use the grafana UI `export` feature** as this will template the datasource and will not work due to that).
3. Save the json contents you have copied in previous step into a new file in folder `grafana\dashboards` with extension .json  (e.g. `mydashboard-02.json`)
4. Substitute the ID number you can find in that file just after field `"graphTooltip"` by `null`.  E.g. ` "id": 1,` should be changed into ` "id": null,`
5. Commit your changes in git and push them to your balena git remote endpoint (`git push balena master`)

## 5. Node-RED
The application consists a [Node-RED](https://nodered.org/) container: 
1. **node-red**: its editor is accessble through Host OS port and path : `<Host OS>:1880/node-red/`

Note that the Node-RED editor protected by a user name and a **hashed** password that must be set through the environment variables `USERNAME` and  `PASSWORD`. The [Node-RED security page](https://nodered.org/docs/security) describes how a password hash can be generated.  You can set these environment variables using your [Balena dashboard](https://dashboard.balena-cloud.com) either under:
- *Application Environment Variables (E(X))* - this implies that both Node-RED instances will have the same username and password.
- *Service Variables (S(X))*

*Notes:*
1. `node-red-data`is a named volumed used for the `\data` folder.  Take care that the `settings.js` is only copied during the initial deployment of the application.  So when the application is redeployed e.g. due to changes, then the `settings.js` is not recopied to the `\data` folder. (see also [How to copy a file to a named volume?](https://forums.balena.io/t/how-to-copy-a-file-to-a-named-volume/4331))
2. In order to assure that nodes installed through `npm install` are not lost after a restart of the container, you must assure that they are installed in the `\data` directory. So you must first do a `cd \data` and then execute the `npm install ....` command. This will assure that the node is correctly installed under folder `\data\node_modules\` and that it will persist after restarts of the container.

## 6. MQTT broker
This application consist of [Mosquitto MQTT-brokers](https://mosquitto.org/):
1. **mqtt** which is listening to Host OS port 1883

## 7. Setup of the USB memory Stick for Influxdb
The data of the influxdb will be stored in the mount location `\mnt\influxdb`.
The *influxdb* container is configured (see Dockerfile and my_entrypoint.sh) so that a USB drive (e.g. a USB memory stick) with label `influxdb` will be mounted to this mount location.  It is currently also expecting (see Dockerfile) that this USB drive is formatted in `ext4` format.

If no USB drive (or memory stick) with label `influxdb` is connected to the raspberry pi then the named volume `influxdb-data` will be mounted to this location as is specified in the `docker-compose.yml` file.

Notes
1. the current *Balena* version doesn't yet support the definition of a volume for such a mounted drive in the docker compose yaml file therefore this is handled through the influxdb container setup as described here above.
2. It is not possible to mount the same USB drive also in telegraf container (I have tried that) and consequently telegraf is not able to report the `disk` metrics for this USB drive.

## 8. Internet access via Balena's public URL and Nginx.
The [nginx](http://nginx.org/en/docs/) container has been configured so that when you enable the Balena public device URL that you can access the following applications over the internet:
- *Grafana* User Interface via `<public device URL>`
- Node-RED editor of the container *node-red* via `<public device URL>\node-red`
- Node-Red dashboard UI of the container *node-red* via `<public device URL>\node-red\ui`

In case you get a `502 Bad Gateway`error or a message like `Cannot GET /node-red/` when trying to access the above public URLs then this might be fixed by restarting the nginx container !

## Credits
1. [Initializing Grafana with preconfigured dashboards](https://ops.tips/blog/initialize-grafana-with-preconfigured-dashboards/)  [(github repository)](https://github.com/cirocosta/sample-grafana)
2. [InfluxDB system metrics dashboard](https://grafana.com/dashboards/1138)
3. [Grafana Series Part 1: Setting up InfluxDB, Grafana and Telegraf with Docker on Linux](https://blog.linuxserver.io/2017/11/25/how-to-monitor-your-server-using-grafana-influxdb-and-telegraf/)
