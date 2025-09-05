#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1090
source <(curl -fsSL --proto '=https' --tlsv1.3 https://gist.xeptore.dev/run.sh)

run <<BASH
curl -sSfL --tlsv1.3 'https://api.github.com/repos/go-acme/lego/releases?per_page=1&page=1' | jq '.[0].tag_name' | xargs -I {} curl -sSfL --tlsv1.3 --proto '=https' 'https://github.com/go-acme/lego/releases/download/{}/lego_{}_linux_amd64.tar.gz' | tar -xzvf - lego
BASH
