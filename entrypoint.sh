#!/bin/sh
# Generates the xray config from environment variables and runs xray.
# Required env: UUID. Optional env: WS_PATH (default /ws), PORT (default 8080, set by the platform).
set -e
: "${PORT:=8080}"
: "${UUID:?UUID env required}"
: "${WS_PATH:=/ws}"
cat > /app/config.json <<EOF
{
  "log": {"loglevel": "warning"},
  "inbounds": [{
    "port": $PORT,
    "protocol": "vless",
    "settings": {"clients": [{"id": "$UUID"}], "decryption": "none"},
    "streamSettings": {"network": "ws", "wsSettings": {"path": "$WS_PATH"}}
  }],
  "outbounds": [{"protocol": "freedom"}]
}
EOF
exec /app/xray run -c /app/config.json
