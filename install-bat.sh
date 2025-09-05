#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1090
source <(curl -fsSL --proto '=https' --tlsv1.3 https://gist.xeptore.dev/run.sh)

run <<BASH
curl -sSfL --tlsv1.3 --proto '=https' 'https://api.github.com/repos/sharkdp/bat/releases?per_page=1&page=1' | jq '.[0].tag_name' | xargs -I {} bash -c "curl -sSfL --tlsv1.3 --proto '=https' 'https://github.com/sharkdp/bat/releases/download/{}/bat-{}-x86_64-unknown-linux-musl.tar.gz' | tar -xzf - bat-{}-x86_64-unknown-linux-musl/bat --strip-components=1"
BASH
