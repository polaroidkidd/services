FROM jonoh/cloudflared:latest


COPY ./config/cert.pem /usr/local/etc/cloudflared/cert.pem
COPY ./config/config.yaml /usr/local/etc/cloudflared/config.yaml
COPY ./config/bb5fa58d-9c84-4084-8a73-fb36109c5e7d.json /usr/local/etc/cloudflared/bb5fa58d-9c84-4084-8a73-fb36109c5e7d.json
COPY ./scripts/entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]