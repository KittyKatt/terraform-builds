resource "kubernetes_namespace" "external-dns-freeipa" {
  metadata {
    name = "external-dns-freeipa"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels
    ]
  }

  depends_on = [
    var.k3s_cluster_created
  ]
}

resource "kubernetes_secret" "freeipa-rfc2136" {
  metadata {
    name      = "freeipa-rfc2136"
    namespace = kubernetes_namespace.external-dns-freeipa.metadata[0].name
  }

  data = {
    "rfc2136_tsig_secret" = "${var.ipa_dnssec_key}"
  }

  type = "Opaque"

  depends_on = [
    kubernetes_namespace.external-dns-freeipa
  ]
}

resource "helm_release" "external-dns-freeipa" {
  name             = "freeipa-external-dns"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "external-dns"
  # version          = "0.10.2"
  namespace        = kubernetes_namespace.external-dns-freeipa.metadata[0].name
  create_namespace = false
  cleanup_on_fail  = true

  values = [
    templatefile(
      "${path.module}/conf/values/external-dns-freeipa.yml",
      {
        dns_zone    = var.domain_name
        ipa_fqdn    = var.ipa_fqdn
        secret_name = kubernetes_secret.freeipa-rfc2136.metadata[0].name
        key_name    = "k8s"
      }
    )
  ]
}