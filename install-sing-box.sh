#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1090
source <(curl -fsSL --proto '=https' --tlsv1.3 https://gist.xeptore.dev/run.sh)

run <<BASH
curl -sSfL --tlsv1.3 --proto '=https' 'https://api.github.com/repos/z4x7k/sing-box-all/releases?per_page=1&page=1' | jq '.[0].tag_name' | xargs -I {} curl -sfLO --tlsv1.3 --proto '=https' 'https://github.com/z4x7k/sing-box-all/releases/download/{}/sing-box' && chmod +x sing-box
BASH
