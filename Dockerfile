FROM alpine:3.21
RUN apk add --no-cache curl ca-certificates unzip
WORKDIR /app
RUN curl -sSLf -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && unzip -o xray.zip xray && chmod +x xray && rm -f xray.zip
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
CMD ["/app/entrypoint.sh"]
