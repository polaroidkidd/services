FROM nextcloud:28.0.2-apache


# Increse memory limits
RUN echo memory_limit=24576M > /usr/local/etc/php/conf.d/memory-limit.ini
RUN apt-get -y update && \
    apt-get install -y ffmpeg imagemagick && \
    apt-get clean


# OP Cache Configuration
COPY ./config/opcache-recommended.ini /usr/local/etc/php/conf.d/

# Copy nextcloud config
COPY config/memories.config.php /var/www/html/config/memories.config.php

# Memories app requires ffmpeg
RUN apt update && apt install ffmpeg -y