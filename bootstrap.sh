#!/bin/bash

set -eo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." >&2
  exit 1
fi

# shellcheck disable=SC1090
source <(curl -fsSL --proto '=https' --tlsv1.3 https://gist.xeptore.dev/run.sh)

run_bail() {
  local snippet
  if (($#)); then
    snippet="$*"
  else
    snippet="$(cat)"  # read from stdin (heredoc)
  fi

  run "$snippet"
  local ec="$?"
  if [[ "$ec" -ne 0 ]]; then
    exit "$ec"
  fi
}

run_bail 'cd /root'

run_bail 'apt update && apt upgrade -y && apt autoremove -y && apt clean -y'
run_bail 'apt install -y jq net-tools unzip curl tree wireguard wireguard-tools nload btop ufw'

run_bail 'curl -sfL --tlsv1.3 --proto '=https' -o .bash_profile https://gist.xeptore.dev/.bash_profile'
run_bail 'source .bash_profile'

run_bail 'curl -sfL --tlsv1.3 --proto '=https' -o .bash_aliases https://gist.xeptore.dev/.bash_aliases'
run_bail 'source .bash_aliases'

run_bail 'curl -sSfL --tlsv1.3 --proto '=https' https://gist.xeptore.dev/install-bat.sh | bash'
run_bail 'mv ./bat /usr/local/bin/bat'

run_bail 'curl -sSfL --tlsv1.3 --proto '=https' https://gist.xeptore.dev/install-dust.sh | bash'
run_bail 'mv ./dust /usr/local/bin/dust'

run_bail 'mkcd /root/lego'
run_bail 'curl -sSfL --tlsv1.3 --proto '=https' https://gist.xeptore.dev/install-lego.sh | bash'

run_bail 'mkcd /root/xray'
run_bail 'curl -sSfL --tlsv1.3 --proto '=https' https://gist.xeptore.dev/install-xray.sh | bash'
run_bail 'curl -sSfL --tlsv1.3 --proto '=https' -o server.json https://gist.xeptore.dev/xray/server.json'

run_bail 'mkcd /root/rathole'
run_bail 'curl -sSfL --tlsv1.3 --proto '=https' https://gist.xeptore.dev/install-rathole.sh | bash'
run_bail 'curl -sSfL --tlsv1.3 --proto '=https' -o server.toml https://gist.xeptore.dev/rathole/server.toml'
run_bail 'curl -sSfL --tlsv1.3 --proto '=https' -o client.toml https://gist.xeptore.dev/rathole/client.toml'

run_bail 'mkcd /root/backhaul'
run_bail 'curl -sSfL --tlsv1.3 --proto '=https' https://gist.xeptore.dev/install-backhaul.sh | bash'

run_bail 'mkcd /root/dnsproxy'
run_bail 'curl -sSfL --tlsv1.3 --proto '=https' https://gist.xeptore.dev/install-dnsproxy.sh | bash'
run_bail 'curl -sSfL --tlsv1.3 --proto '=https' -o config.yaml https://gist.xeptore.dev/dnsproxy/config.yaml'

run_bail 'mkcd /root/sing-box'
run_bail 'curl -sSfL --tlsv1.3 --proto '=https' https://gist.xeptore.dev/install-sing-box.sh | bash'

run_bail 'curl -sfL --tlsv1.3 --proto '=https' -o /etc/systemd/system/xray@.service https://gist.xeptore.dev/systemd/xray@.service'
run_bail 'curl -sfL --tlsv1.3 --proto '=https' -o /etc/systemd/system/backhaul@.service https://gist.xeptore.dev/systemd/backhaul@.service'
run_bail 'curl -sfL --tlsv1.3 --proto '=https' -o /etc/systemd/system/dnsproxy@.service https://gist.xeptore.dev/systemd/dnsproxy@.service'
run_bail 'curl -sfL --tlsv1.3 --proto '=https' -o /etc/systemd/system/rathole@.service https://gist.xeptore.dev/systemd/rathole@.service'
run_bail 'curl -sfL --tlsv1.3 --proto '=https' -o /etc/systemd/system/sing-box@.service https://gist.xeptore.dev/systemd/sing-box@.service'

run_bail 'systemctl daemon-reload'

run_bail 'curl -sfL --tlsv1.3 --proto '=https' https://gist.xeptore.dev/etc/sysctl.d/99-proxy.conf -o /etc/sysctl.d/99-proxy.conf'

run_bail <<'BASH'
cat>~/.vimrc <<'EOF'
set nu rnu nowrap
syntax on
set cursorline
set encoding=utf-8
set ttyfast
set showmode
EOF
BASH

run_bail <<'BASH'
cat>~/ufw.sh <<'EOF'
#!/bin/bash

set -euxo pipefail

ip=?
if=?

ufw reset

ufw rule allow in on "$if" proto tcp to "$ip/32" port ? comment 'SSH'

ufw rule allow in on "$if" proto tcp from ? to "$ip/32" port ? comment 'Rathole - Tunnel'
ufw rule allow in on "$if" proto tcp to "$ip/32" port ? comment 'Rathole - X'

ufw rule allow in on "$if" proto tcp to "$ip/32" port 80 comment 'HTTP'
ufw rule allow in on "$if" proto tcp to "$ip/32" port 443 comment 'HTTPS'
EOF
chmod +x ~/ufw.sh
BASH

run_bail <<'BASH'
cat>~/ipv6-disable.sh <<'EOF'
#!/bin/bash

set -euxo pipefail

sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.lo.disable_ipv6=1
EOF
chmod +x ~/ipv6-disable.sh
BASH

run_bail <<'BASH'
cat>~/ipv6-enable.sh <<'EOF'
#!/bin/bash

set -euxo pipefail

sysctl -w net.ipv6.conf.all.disable_ipv6=0
sysctl -w net.ipv6.conf.default.disable_ipv6=0
sysctl -w net.ipv6.conf.lo.disable_ipv6=0
EOF
chmod +x ~/ipv6-enable.sh
BASH

run_bail <<'BASH'
cat>~/.tmux.conf <<'EOF'
set -g default-terminal "screen"
EOF
BASH

run 'systemctl disable --now unattended-upgrades.service'

run_bail 'apt update && apt upgrade -y && apt autoremove -y && apt clean -y'
run_bail 'apt update && apt upgrade -y && apt autoremove -y && apt clean -y'
