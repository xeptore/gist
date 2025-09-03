#!/bin/bash

set -euo pipefail

curl -sSfL --tlsv1.3 'https://api.github.com/repos/Musixal/Backhaul/releases?per_page=1&page=1' | jq '.[0].tag_name' | xargs -I {} curl -sSfL --tlsv1.3 'https://github.com/Musixal/Backhaul/releases/download/{}/backhaul_linux_amd64.tar.gz' | tar -xzf - backhaul
