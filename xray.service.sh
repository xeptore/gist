cat >/etc/systemd/system/xray.service <<EOF
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
ExecStart=$(pwd)/xray run --config $(pwd)/config.json
WorkingDirectory=$(pwd)
Restart=on-failure
RestartSec=10
RestartPreventExitStatus=23
LimitNPROC=infinity
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
EOF
