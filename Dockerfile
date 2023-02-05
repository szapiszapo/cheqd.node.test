FROM traefik:latest
RUN apk add --no-cache bash
ARG PROJECT_NAME
ENV env_name $PROJECT_NAME
WORKDIR /opt/$PROJECT_NAME
COPY traefik-entrypoint.sh /traefik-entrypoint.sh
RUN chmod +x /traefik-entrypoint.sh
ENTRYPOINT ["/traefik-entrypoint.sh" ; "/entrypoint.sh"]
# CMD [ "--allow-to-run-as-root", "--nodaemonize" ]