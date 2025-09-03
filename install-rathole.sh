#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1090
source <(curl -fsSL --proto '=https' --tlsv1.3 https://gist.xeptore.dev/run.sh)

run <<BASH
curl \
  -sSfL \
  --tlsv1.3 \
  --proto '=https' \
  'https://api.github.com/repos/rathole-org/rathole/releases?per_page=1&page=1' \
  | jq '.[0].tag_name' \
  | xargs -I {} curl \
    -sSfL \
    --tlsv1.3 \
    -o rathole.zip \
    'https://github.com/rathole/rathole/releases/download/{}/rathole-x86_64-unknown-linux-gnu.zip' \
  && unzip -qo rathole.zip \
  && rm rathole.zip
BASH
