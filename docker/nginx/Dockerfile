FROM nginx
VOLUME ["/usr/local/etc/nginx"]
#use :confvol container to copy config to this volume
RUN apt-get update && \
  apt-get install -y curl && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
# to check if nginx is running run: curl http://localhost
RUN { \
  echo '#!/bin/sh'; \
  echo 'set -eu'; \
  echo 'cp -f /usr/local/etc/nginx/nginx.conf /etc/nginx/nginx.conf'; \
  echo 'exec "$@"'; \
  } > /entrypoint.sh; \
  chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
HEALTHCHECK --interval=10s --timeout=3s --start-period=5s \
        CMD \
        curl -f http://localhost:80/ping || exit 1
