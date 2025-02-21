FROM nginx:1.27.3

# Create Volumes
VOLUME /etc/letsencrypt
VOLUME /var/www/.well-known/acme-challenge/

EXPOSE 47808
EXPOSE 47809
# Do this apt/pip stuff all in one RUN command to avoid creating large
# intermediate layers on non-squashable docker installs
RUN apt update && \
    apt install -y inotify-tools bash && \
    apt remove --purge -y && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy nginx configs
COPY ./conf/nginx.prod.conf /etc/nginx/nginx.prod.conf
COPY ./conf/nginx.dev.conf /etc/nginx/nginx.dev.conf

# Copy Scripts
COPY scripts /scripts
RUN chmod +x /scripts/*.sh

ENTRYPOINT []
CMD sh -c "/scripts/entrypoint.sh"