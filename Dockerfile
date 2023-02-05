FROM traefik:latest
RUN apk add --no-cache bash
ARG PROJECT_NAME
ENV env_name $PROJECT_NAME
ENV CHEQD_TRAEFIK_USERNAME DOCKER-SECRET->TRAEFIK_USERNAME
ENV CHEQD_TRAEFIK_HASHED_PASSWORD DOCKER-SECRET->TRAEFIK_HASHED_PASSWORD
ENV CHEQD_TRAEFIK_DOMAIN DOCKER-SECRET->TRAEFIK_DOMAIN
ENV CHEQD_LE_AUTH_EMAIL DOCKER-SECRET->LE_AUTH_EMAIL
WORKDIR /opt/$PROJECT_NAME
COPY traefik-entrypoint.sh /traefik-entrypoint.sh
RUN chmod +x /traefik-entrypoint.sh
ENTRYPOINT [ "/bin/sh", "-c", "source /traefik-entrypoint.sh ; source /entrypoint.sh" ]
# CMD [ "--allow-to-run-as-root", "--nodaemonize" ]