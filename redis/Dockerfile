FROM redis:6.0.8

# Define Ports
EXPOSE 6379

# Copy redis config
RUN mkdir -p /usr/local/etc/redis/
COPY ./conf/redis.conf /usr/local/etc/redis/redis.conf
