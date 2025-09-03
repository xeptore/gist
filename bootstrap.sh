#!/bin/bash

set -exuo pipefail

cd /root

apt-get update
apt-get upgrade -y
apt-get autoremove -y
apt-get clean -y
apt-get install -y jq net-tools unzip curl tree wireguard wireguard-tools nload btop

curl -sfL --tlsv1.3 -o .bash_profile https://gist.xeptore.dev/.bash_profile
source .bash_profile

curl -sfL --tlsv1.3 -o .bash_aliases https://gist.xeptore.dev/.bash_aliases
source .bash_aliases

mkcd /root/lego
curl -sSfL --tlsv1.3 https://gist.xeptore.dev/install-lego.sh | bash

mkcd /root/xray
curl -sSfL --tlsv1.3 https://gist.xeptore.dev/install-xray.sh | bash

mkcd /root/rathole
curl -sSfL --tlsv1.3 https://gist.xeptore.dev/install-rathole.sh | bash

mkcd /root/backhaul
curl -sSfL --tlsv1.3 https://gist.xeptore.dev/install-backhaul.sh | bash

mkcd /root/dnsproxy
curl -sSfL --tlsv1.3 https://gist.xeptore.dev/install-dnsproxy.sh | bash

mkcd /root/sing-box
curl -sSfL --tlsv1.3 https://gist.xeptore.dev/install-sing-box.sh | bash

curl -sfL --tlsv1.3 -o /etc/systemd/system/xray@.service https://gist.xeptore.dev/systemd/xray@.service
curl -sfL --tlsv1.3 -o /etc/systemd/system/backhaul@.service https://gist.xeptore.dev/systemd/backhaul@.service
curl -sfL --tlsv1.3 -o /etc/systemd/system/dnsproxy@.service https://gist.xeptore.dev/systemd/dnsproxy@.service
curl -sfL --tlsv1.3 -o /etc/systemd/system/rathole@.service https://gist.xeptore.dev/systemd/rathole@.service
curl -sfL --tlsv1.3 -o /etc/systemd/system/sing-box@.service https://gist.xeptore.dev/systemd/sing-box@.service

systemctl daemon-reload
