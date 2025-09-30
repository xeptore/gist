#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1090
source <(curl -fsSL --proto '=https' --tlsv1.3 https://gist.xeptore.dev/run.sh)

run <<BASH
curl -sSfL --tlsv1.3 --proto '=https' 'https://api.github.com/repos/Loyalsoldier/v2ray-rules-dat/releases?per_page=1&page=1' | jq '.[0].tag_name' | xargs -I {} curl -sfLO --tlsv1.3 --proto '=https' 'https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/{}/geoip.dat' 'https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/{}/geosite.dat'
BASH
