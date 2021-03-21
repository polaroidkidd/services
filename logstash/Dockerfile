FROM logstash:7.11.1

COPY ./config/logstash.yml /usr/share/logstash/config/logstash.yml
COPY ./pipeline/pipelines.yml /usr/share/logstash/config/pipelines.yml
COPY ./pipeline/logstash.nginx.conf /usr/share/logstash/config/logstash.nginx.conf