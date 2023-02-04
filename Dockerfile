FROM busybox
ARG PROJECT_NAME
ENV env_name $PROJECT_NAME
WORKDIR /opt/$PROJECT_NAME
COPY traefik-entrypoint.sh /traefik-entrypoint.sh
RUN chmod +x /traefik-entrypoint.sh
# ENTRYPOINT ["/usr/local/bin/traefik-entrypoint.sh"]