FROM jonoh/cloudflared:latest


COPY ./config/cert.pem /usr/local/etc/cloudflared/cert.pem
COPY ./config/config.yaml /usr/local/etc/cloudflared/config.yaml
COPY ./config/d207d6c3-0a62-4bfa-a910-54bc92923be4.json /usr/local/etc/cloudflared/d207d6c3-0a62-4bfa-a910-54bc92923be4.json
COPY ./scripts/entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]