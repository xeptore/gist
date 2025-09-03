#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1090
source <(curl -fsSL --proto '=https' --tlsv1.3 https://gist.xeptore.dev/run.sh)

run <<BASH
apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -sSLf --tlsv1.3 --proto '=https' 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor --yes --output /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -sSLf --tlsv1.3 --proto '=https' 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
chmod o+r /usr/share/keyrings/caddy-stable-archive-keyring.gpg
chmod o+r /etc/apt/sources.list.d/caddy-stable.list
apt update
apt install -y caddy
BASH
