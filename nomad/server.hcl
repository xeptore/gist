data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"
log_level = "WARN"

advertise {
  http = "public_ip"
  rpc  = "public_ip"
  serf = "public_ip"
}

server {
  enabled = true
  # Number of other servers in the cluster
  bootstrap_expect = 1
}

tls {
  http                   = true
  rpc                    = true
  ca_file                = "/etc/nomad.d/certs/nomad-agent-ca.pem"
  cert_file              = "/etc/nomad.d/certs/global-server.pem"
  key_file               = "/etc/nomad.d/certs/global-server-key.pem"
  verify_server_hostname = true
  verify_https_client    = true
}
