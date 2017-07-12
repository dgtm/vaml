backend "consul" {
  address = "consul:8500"
  path = "vault"
  scheme = "http"
}

listener "tcp" {
  address = "vault:8200"
  tls_disable = 1
}

disable_mlock = true
