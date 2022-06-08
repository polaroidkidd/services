FROM nextcloud:24.0.1-apache

# Increse memory limits
RUN echo memory_limit=24576M > /usr/local/etc/php/conf.d/memory-limit.ini

# OP Cache Configuration
COPY ./config/opcache-recommended.ini /usr/local/etc/php/conf.d/