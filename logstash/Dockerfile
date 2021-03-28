FROM logstash:7.11.1

COPY ./config/logstash.yml /usr/share/logstash/config/logstash.yml
COPY ./pipeline/pipelines.yml /usr/share/logstash/config/pipelines.yml
COPY ./pipeline/logstash.nginx.conf /usr/share/logstash/config/logstash.nginx.conf
COPY pipeline/logstash.fail2ban.conf /usr/share/logstash/config/logstash.fail2ban.conf
RUN mkdir -p /usr/share/logstash/patterns
COPY ./patterns /usr/share/logstash/patterns