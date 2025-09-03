#!/bin/bash

set -eo pipefail

run() {
  local snippet="$*"

  # Preview: substitute environment variables for display only (no $(...))
  if command -v envsubst >/dev/null 2>&1; then
    printf '+ %s\n' "$(envsubst <<<"$snippet")" >&2
  else
    # Fallback preview if envsubst isn't available
    printf '+ %s\n' "$snippet" >&2
  fi

  # Execute in current shell so sourced functions/vars are visible
  # Temporarily enable pipefail and then restore previous shell options
  local _saved_opts
  _saved_opts="$(set +o)"          # capture current option states
  set -o pipefail

  eval "$snippet"
  local rc=$?

  eval "$_saved_opts"              # restore options exactly as they were
  return "$rc"
}

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
