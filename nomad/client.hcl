data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"
log_level = "WARN"

advertise {
  # Even if in a private network, or NAT, use public IP
  http = "public_ip"
  rpc  = "public_ip"
  serf = "public_ip"
}

client {
  enabled           = true
  servers           = ["server.global.nomad:4647"]
  network_interface = "eth0"
}

tls {
  http                   = true
  rpc                    = true
  ca_file                = "/etc/nomad.d/certs/nomad-agent-ca.pem"
  cert_file              = "/etc/nomad.d/certs/global-client.pem"
  key_file               = "/etc/nomad.d/certs/global-client-key.pem"
  verify_server_hostname = true
  verify_https_client    = true
}

plugin "docker" {
  config {
    allow_privileged = true
  }
}

consul {
  address = "127.0.0.1:8500"
}

ui {
  enabled = false
}
