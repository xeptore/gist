#!/bin/bash

set -exuo pipefail

curl -sSfL --tlsv1.3 'https://api.github.com/repos/XTLS/Xray-core/releases?per_page=1&page=1' | jq '.[0].tag_name' | xargs -I {} curl -sfL --tlsv1.3 -o xray.zip https://github.com/XTLS/Xray-core/releases/download/{}/Xray-linux-64.zip && unzip -o xray.zip && rm LICENSE README.md xray.zip
