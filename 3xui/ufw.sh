ufw rule allow in on br-3xui0 proto tcp from 172.31.0.2/32 to 172.30.0.1/32 port 10801 comment '3xui Container -> host.docker.internal'
ufw rule allow in on lo proto tcp from 172.30.0.1/32 to 127.0.0.1 port 10801 comment '3xui Socat -> sing-box'
