FROM certbot/dns-digitalocean:latest

LABEL MAINTAINER="Daniel L. Einars"
LABEL CONTACT="contact@dle.dev"

VOLUME /etc/letsencrypt
VOLUME /var/www/.well-known/acme-challenge/


# Copy Scripts
COPY ./scripts /scripts
# Make scripts runnable
RUN chmod +x /scripts/*.sh
ARG DIGITALOCEAN_ACCESS_TOKEN
RUN echo "# DigitalOcean API credentials used by Certbot" >> /scripts/digitalocean.ini
RUN echo "dns_digitalocean_token = ${DIGITALOCEAN_ACCESS_TOKEN}" > /scripts/digitalocean.ini
# Copy crontab
COPY ./scripts/crontab /etc/cron.d/certbot
RUN crontab /etc/cron.d/certbot

#Expose Ports
EXPOSE 80
EXPOSE 443

ENTRYPOINT []
CMD sh -c "/scripts/entrypoint.sh; crond -f"
