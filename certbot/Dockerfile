FROM certbot/dns-cloudflare:latest

LABEL MAINTAINER="Daniel L. Einars"
LABEL CONTACT="contact@dle.dev"

VOLUME /etc/letsencrypt
VOLUME /var/www/.well-known/acme-challenge/


# Copy Scripts
COPY ./scripts /scripts
# Make scripts runnable
RUN chmod +x /scripts/*.sh
ARG DNS_CLOUDFLARE_API_TOKEN
RUN echo "# DigitalOcean API credentials used by Certbot" >> /scripts/cloudflare.ini
RUN echo "dns_cloudflare_api_token = ${DNS_CLOUDFLARE_API_TOKEN}" > /scripts/cloudflare.ini
# Copy crontab
COPY ./scripts/crontab /etc/cron.d/certbot
RUN crontab /etc/cron.d/certbot

#Expose Ports
EXPOSE 80
EXPOSE 443

ENTRYPOINT []
CMD sh -c "/scripts/entrypoint.sh; crond -f"
