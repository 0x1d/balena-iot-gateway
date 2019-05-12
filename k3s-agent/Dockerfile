FROM rancher/k3s:v0.5.0-arm
WORKDIR /k3s
COPY . .
ENTRYPOINT [ "/bin/bash", "/k3s/start.sh" ]