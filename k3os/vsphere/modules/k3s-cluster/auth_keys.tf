resource "random_password" "node_token" {
  length  = 48
  special = false
}

resource "random_password" "k8s_admin_token" {
  length  = 48
  special = false
}

locals {
  node_token = random_password.node_token.result
  k8s_admin_token = random_password.k8s_admin_token.result
  # https://kubernetes.io/docs/reference/access-authn-authz/authentication/#static-token-file
  k8s_token_file = {
    path    = "/etc/opt/k8s-static-tokens"
    content = "${local.k8s_admin_token},terraform-admin,1000,system:masters"
  }
}

output "k8s_api_token" {
  value     = local.k8s_admin_token
}
output "node_token" {
  value     = local.node_token
}