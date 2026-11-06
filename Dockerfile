# xray on Cloady (usw1 node) — multi-stage Dockerfile
# Stage 1: fetch the official Xray-core binary (no shell needed from the
# official image; we download the release zip here instead).
# Stage 2: minimal Alpine runtime, binary copied in, shell available.
FROM alpine:3.21 AS downloader
RUN apk add --no-cache curl unzip
WORKDIR /dl
RUN curl -sSLf -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
 && unzip -o xray.zip xray \
 && chmod +x xray \
 && rm -f xray.zip

FROM alpine:3.21
RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=downloader /dl/xray /app/xray
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/xray /app/entrypoint.sh
CMD ["/app/entrypoint.sh"]
