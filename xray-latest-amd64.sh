#!/bin/bash

set -exuo pipefail

curl -SfLO --tlsv1.3 https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
unzip -o Xray-linux-64.zip
rm LICENSE README.md Xray-linux-64.zip
