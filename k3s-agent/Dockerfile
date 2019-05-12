FROM rancher/k3s:v0.5.0-arm
COPY . .
RUN chmod +x start.sh
#ENTRYPOINT [ "/bin/sh" "start.sh" ]
ENTRYPOINT ["./start.sh"]