FROM rancher/k3s:v0.5.0-arm
COPY scripts /usr/src
RUN chmod +x /usr/srcstart.sh
#ENTRYPOINT [ "/bin/sh" "start.sh" ]
CMD /usr/src/start.sh