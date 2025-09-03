#!/bin/bash

set -eo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." >&2
  exit 1
fi

# shellcheck disable=SC1090
source <(curl -fsSL --proto '=https' --tlsv1.3 https://gist.xeptore.dev/run.sh)

run 'cd /root'

run 'apt-get update'
run 'apt-get upgrade -y'
run 'apt-get autoremove -y'
run 'apt-get clean -y'
run 'apt-get install -y jq net-tools unzip curl tree wireguard wireguard-tools nload btop'

run 'curl -sfL --tlsv1.3 -o .bash_profile https://gist.xeptore.dev/.bash_profile'
run 'source .bash_profile'

run 'curl -sfL --tlsv1.3 -o .bash_aliases https://gist.xeptore.dev/.bash_aliases'
run 'source .bash_aliases'

run 'curl -sSfL --tlsv1.3 https://gist.xeptore.dev/install-bat.sh | bash'
run 'mv ./bat /usr/local/bin/bat'

run 'curl -sSfL --tlsv1.3 https://gist.xeptore.dev/install-dust.sh | bash'
run 'mv ./dust /usr/local/bin/dust'

run 'mkcd /root/lego'
run 'curl -sSfL --tlsv1.3 https://gist.xeptore.dev/install-lego.sh | bash'

run 'mkcd /root/xray'
run 'curl -sSfL --tlsv1.3 https://gist.xeptore.dev/install-xray.sh | bash'

run 'mkcd /root/rathole'
run 'curl -sSfL --tlsv1.3 https://gist.xeptore.dev/install-rathole.sh | bash'

run 'mkcd /root/backhaul'
run 'curl -sSfL --tlsv1.3 https://gist.xeptore.dev/install-backhaul.sh | bash'

run 'mkcd /root/dnsproxy'
run 'curl -sSfL --tlsv1.3 https://gist.xeptore.dev/install-dnsproxy.sh | bash'

run 'mkcd /root/sing-box'
run 'curl -sSfL --tlsv1.3 https://gist.xeptore.dev/install-sing-box.sh | bash'

run 'curl -sfL --tlsv1.3 -o /etc/systemd/system/xray@.service https://gist.xeptore.dev/systemd/xray@.service'
run 'curl -sfL --tlsv1.3 -o /etc/systemd/system/backhaul@.service https://gist.xeptore.dev/systemd/backhaul@.service'
run 'curl -sfL --tlsv1.3 -o /etc/systemd/system/dnsproxy@.service https://gist.xeptore.dev/systemd/dnsproxy@.service'
run 'curl -sfL --tlsv1.3 -o /etc/systemd/system/rathole@.service https://gist.xeptore.dev/systemd/rathole@.service'
run 'curl -sfL --tlsv1.3 -o /etc/systemd/system/sing-box@.service https://gist.xeptore.dev/systemd/sing-box@.service'

run 'systemctl daemon-reload'

run 'apt-get update'
run 'apt-get upgrade -y'
run 'apt-get autoremove -y'
run 'apt-get clean -y'
