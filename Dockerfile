FROM alpine:3.21
RUN apk add --no-cache curl ca-certificates unzip
WORKDIR /app
RUN curl -sL https://api.github.com/repos/XTLS/Xray-core/releases/latest | grep '"browser_download_url".*Xray-linux-64.zip"' | cut -d'"' -f4 | xargs curl -sL -o xray.zip && unzip -o xray.zip xray && chmod +x xray && rm xray.zip
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
CMD ["/app/entrypoint.sh"]
