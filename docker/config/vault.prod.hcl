backend "consul" {
  address = "my_server_address:8500"
  redirect_addr = "https://vault:8200"
  path = "vault"
  scheme = "https"
  tls_skip_verify = 0
  tls_cert_file= "/config/cert.pem"
  tls_key_file = "/config/privkey.pem"
  tls_ca_file = "/config/fullchain.pem"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 0
  tls_cert_file = "/config/cert.pem"
  tls_key_file = "/config/privkey.pem"
  cluster_address = "0.0.0.0:8200"
}

disable_mlock = true
