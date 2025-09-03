#!/bin/bash

set -exuo pipefail

curl -sSfL --tlsv1.3 'https://api.github.com/repos/z4x7k/sing-box-all/releases?per_page=1&page=1' | jq '.[0].tag_name' | xargs -I {} curl -sSfL --tlsv1.3 'https://github.com/z4x7k/sing-box-all/releases/download/{}/sing-box' && chmod +x sing-box
