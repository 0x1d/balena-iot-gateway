FROM rancher/k3s:v0.5.0-arm
COPY scripts/start.sh start.sh
RUN chmod +x start.sh
ENTRYPOINT [ "start.sh" ]
CMD start.sh