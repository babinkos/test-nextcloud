#FROM  as builder
FROM jwilder/nginx-proxy:alpine
LABEL maintainer="babinkos 37809416+babinkos@users.noreply.github.com"
COPY *.sh /
COPY files/nginx.tmpl /app/
COPY files/confd /etc/confd/
COPY files/error.html /usr/share/nginx/html/
ENV DOCKER_GEN_FORK "github.com/babinkos/docker-gen"
ENV DOCKER_GEN_VERSION "0.7.6"
ENV DG_DIST "docker-gen-alpine-linux-musl-amd64"
#ENV DG_TARGZ "docker-gen-alpine-linux-musl-amd64-0.7.6-1-gcdd1ad4-upx.tar.gz"
COPY --from=docker.io/k0s2018/test-nextcloud:docker-gen.builder /artifacts/docker-gen /artifacts/confd /usr/local/bin/
RUN \
 set -ex; \
#  echo "http://alpine.gliderlabs.com/alpine/v$(cut -d'.' -f1,2 /etc/alpine-release)/main" > /etc/apk/repositories; \
 apk -U --no-cache add curl file; \
# echo "Downloading: https://$DOCKER_GEN_FORK/releases/download/$DOCKER_GEN_VERSION/$DG_DIST-$DOCKER_GEN_VERSION.tar.gz"; \
 #wget --quiet -O "/tmp/$DG_DIST-$DOCKER_GEN_VERSION.tar.gz" "https://$DOCKER_GEN_FORK/releases/download/$DOCKER_GEN_VERSION/$DG_DIST-$DOCKER_GEN_VERSION.tar.gz"; \
# ls -l "/tmp/${DG_TARGZ}"; \
 ls -l /usr/local/bin; \
# tar -xzvf "/tmp/${DG_TARGZ}" -C /usr/local/bin --strip-components=8; \
# rm "/tmp/${DG_TARGZ}"; \
 chown root:root /usr/local/bin/docker-gen; \
 chmod +x /usr/local/bin/docker-gen; \
 chown root:root /usr/local/bin/confd; \
 chmod +x /usr/local/bin/confd; \
# chmod +x /entrypoint.sh; \
 ls -l /usr/local/bin/docker-gen; \
 file /usr/local/bin/docker-gen; \
 sync; \
 /usr/local/bin/docker-gen --version; \
 /usr/local/bin/confd -version; \
 chmod +x /*.sh; \
 mv /docker-entrypoint.sh /app/docker-entrypoint.sh
WORKDIR /app/
HEALTHCHECK --interval=10s --timeout=3s --start-period=15s \
        CMD \
        /test-https.sh || exit 1
ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["forego", "start", "-r"]
