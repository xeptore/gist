#!/bin/bash

set -exuo pipefail

curl -sSfL --tlsv1.3 'https://api.github.com/repos/rathole-org/rathole/releases?per_page=1&page=1' | jq '.[0].tag_name' | xargs -I {} curl -sSfL --tlsv1.3 -o rathole.zip 'https://github.com/rathole/rathole/releases/download/{}/rathole-x86_64-unknown-linux-gnu.zip' && unzip -o rathole.zip && rm rathole.zip
