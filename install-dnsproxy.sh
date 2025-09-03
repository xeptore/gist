#!/bin/bash

set -evuo pipefail

curl -sSfL --tlsv1.3 'https://api.github.com/repos/AdguardTeam/dnsproxy/releases?per_page=1&page=1' | jq '.[0].tag_name' | xargs -I {} curl -sSfL --tlsv1.3 'https://github.com/AdguardTeam/dnsproxy/releases/download/{}/dnsproxy-linux-amd64-{}.tar.gz' | tar -xzvf - ./linux-amd64/dnsproxy --strip-components=2
