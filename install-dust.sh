#!/bin/bash

set -euo pipefail

curl -sSfL --tlsv1.3 'https://api.github.com/repos/bootandy/dust/releases?per_page=1&page=1' | jq '.[0].tag_name' | xargs -I {} bash -c 'curl -sSfL --tlsv1.3 https://github.com/bootandy/dust/releases/download/{}/dust-{}-x86_64-unknown-linux-musl.tar.gz | tar -xzf - dust-{}-x86_64-unknown-linux-musl/dust --strip-components=1'
