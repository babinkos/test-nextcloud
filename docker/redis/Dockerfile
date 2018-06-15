FROM redis:alpine
COPY --from=docker.io/k0s2018/test-nextcloud:docker-gen.builder /artifacts/confd /usr/local/bin/
COPY files/confd /etc/confd/
COPY docker-entrypoint.sh redis.healthcheck.sh /usr/local/bin/
COPY start-redis.sh /
WORKDIR /data
RUN \
  mkdir "/etc/redis"; \
  chmod +x /start-redis.sh; \
  chmod +x /usr/local/bin/*
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/start-redis.sh"]
HEALTHCHECK --interval=10s --timeout=3s --start-period=5s \
        CMD \
        /usr/local/bin/redis.healthcheck.sh || exit 1
