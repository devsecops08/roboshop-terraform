provider "vault" {
  address         = "http://vault-internal.adevseecops08.online:8200"
  token           = var.vault_token
  skip_tls_verify = true
}