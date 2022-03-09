data "kubernetes_secret" "bootstrap_secret" {
  metadata {
    namespace = "cattle-system"
    name      = "bootstrap-secret"
  }

  depends_on = [
    var.rancher_created
  ]
}

resource "rancher2_bootstrap" "admin" {
  provider = rancher2.bootstrap

  initial_password = data.kubernetes_secret.bootstrap_secret.data.bootstrapPassword
  password         = var.rancher_bootstrap_password
  telemetry        = false
}