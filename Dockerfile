FROM traefik:latest
RUN apk add --no-cache bash
ARG PROJECT_NAME
ENV env_name $PROJECT_NAME
WORKDIR /opt/$PROJECT_NAME
COPY /opt/$PROJECT_NAME/traefik-entrypoint.sh /traefik-entrypoint.sh
RUN chmod +x /traefik-entrypoint.sh
ENTRYPOINT [ "/bin/sh", "-c", "source /entrypoint.sh ; source /traefik-entrypoint.sh" ]
# CMD [ "--allow-to-run-as-root", "--nodaemonize" ]