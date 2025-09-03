#!/bin/bash

set -euo pipefail

apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -sSLf --tlsv1.3 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor --yes --output /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sSLf --tlsv1.3 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
chmod o+r /usr/share/keyrings/caddy-stable-archive-keyring.gpg
chmod o+r /etc/apt/sources.list.d/caddy-stable.list
apt update
apt install -y caddy
