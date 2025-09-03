#!/bin/bash

set -euo pipefail

curl -sSfL --tlsv1.3 'https://api.github.com/repos/sharkdp/bat/releases?per_page=1&page=1' | jq '.[0].tag_name' | xargs -I {} bash -c 'curl -sSfL --tlsv1.3 https://github.com/sharkdp/bat/releases/download/{}/bat-{}-x86_64-unknown-linux-musl.tar.gz | tar -xzf - bat-{}-x86_64-unknown-linux-musl/bat --strip-components=1'
