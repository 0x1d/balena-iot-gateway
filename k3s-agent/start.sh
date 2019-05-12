#!/bin/bash

echo "Starting Agent"
ln -s /var/run/balena.sock /var/run/docker.sock
k3s agent --docker