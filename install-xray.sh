#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1090
source <(curl -fsSL --proto '=https' --tlsv1.3 https://gist.xeptore.dev/run.sh)

run <<BASH
curl \
  -sSfL \
  --tlsv1.3 \
  --proto '=https' \
  'https://api.github.com/repos/XTLS/Xray-core/releases?per_page=1&page=1' \
  | jq '.[0].tag_name' \
  | xargs -I {} curl \
    -sfL \
    --tlsv1.3 \
    --proto '=https' \
    -o xray.zip \
    'https://github.com/XTLS/Xray-core/releases/download/{}/Xray-linux-64.zip' \
  && unzip -qo xray.zip \
  && rm LICENSE README.md xray.zip
BASH
