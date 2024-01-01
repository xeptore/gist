cat >/etc/systemd/system/sing-box.service <<EOF
[Unit]
Description=Sing-box Service
Documentation=https://github.com/SagerNet/sing-box
After=network.target nss-lookup.target

[Service]
ExecStart=$(pwd)/sing-box run --config $(pwd)/config.json --config $(pwd)/rule-set.json
WorkingDirectory=$(pwd)
Restart=on-failure
RestartSec=10
RestartPreventExitStatus=23
LimitNPROC=infinity
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
EOF
