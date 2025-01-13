FROM nginx:1.21.3

# Create Volumes

EXPOSE 57808


# Copy nginx configs
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/owntracks-htpasswd /etc/nginx/.htpasswd

# Copy Scripts
COPY scripts /scripts
RUN chmod +x /scripts/*.sh

ENTRYPOINT []
CMD sh -c "/scripts/entrypoint.sh"