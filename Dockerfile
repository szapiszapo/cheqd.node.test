FROM busybox
ENV PROJECT_NAME=$PROJECT_NAME
COPY /opt/$PROJECT_NAME/traefik-entrypoint.sh /usr/local/bin/traefik-entrypoint.sh
RUN chmod +x /traefik-entrypoint.sh
ENTRYPOINT ["traefik-entrypoint.sh"]