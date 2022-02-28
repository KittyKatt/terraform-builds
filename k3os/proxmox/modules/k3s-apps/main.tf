locals {
  letsencrypt_targets = {
    "staging" = "https://acme-staging-v02.api.letsencrypt.org/directory",
    "prod" = "https://acme-v02.api.letsencrypt.org/directory"
  }
  rancher_domain = "rancher.${var.domain_name}"
  tls_secret_name = "cloudflare-api-token-secret"
  tls_secret_key = "api-token"
}