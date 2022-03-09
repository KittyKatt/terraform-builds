resource "kubernetes_namespace" "rancher" {
  metadata {
    name = "cattle-system"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels
    ]
  }

  depends_on = [
    helm_release.nginx,
    helm_release.metallb,
    helm_release.cert-manager
  ]
}

resource "kubernetes_secret" "cloudflare-api-secret" {
  metadata {
    name      = "cloudflare-api-token-secret"
    namespace = kubernetes_namespace.rancher.metadata[0].name
  }

  data = {
    "api-token" = "${var.api_token}"
  }

  type = "Opaque"

  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels
    ]
  }

  depends_on = [
    kubernetes_namespace.rancher
  ]
}

data "helm_template" "rancher-tls" {
  name      = "rancher-tls"
  chart     = "${path.module}/conf/helm/rancher-tls"
  namespace = kubernetes_namespace.rancher.metadata[0].name

  values = [
    templatefile(
      "${path.module}/conf/helm/rancher-tls/values.yml",
      {
        acme_email    = var.acme_email
        acme_server   = terraform.workspace != "dev" ? local.letsencrypt_targets.prod : local.letsencrypt_targets.staging
        dns_name      = local.rancher_domain
        dns_zone      = var.domain_name
        namespace     = kubernetes_namespace.rancher.metadata[0].name
      }
    )
  ]
}

resource "helm_release" "rancher-tls" {
  name      = data.helm_template.rancher-tls.name
  chart     = data.helm_template.rancher-tls.chart
  namespace = data.helm_template.rancher-tls.namespace

  values = data.helm_template.rancher-tls.values

  wait          = true
  wait_for_jobs = true

  # This is a hack to force updates when files in the local helm chart
  # directory update
  set {
    name  = "sourceHash"
    value = md5(data.helm_template.rancher-tls.manifest)
  }

  depends_on = [
    helm_release.cert-manager,
    helm_release.nginx,
    helm_release.metallb,
    kubernetes_secret.cloudflare-api-secret
  ]
}

resource "helm_release" "rancher" {
  name       = "rancher"
  repository = "https://releases.rancher.com/server-charts/latest"
  chart      = "rancher"
  version    = "2.6.3"
  namespace  = kubernetes_namespace.rancher.metadata[0].name
  timeout    = 720

  values = [
    templatefile(
      "${path.module}/conf/values/rancher.yml",
      {
        hostname = local.rancher_domain
      }
    ),
  ]

  depends_on = [
    helm_release.nginx,
    helm_release.metallb,
    helm_release.rancher-tls,
  ]
}

output "rancher_created" {
  value = true
  
  depends_on = [
    helm_release.rancher
  ]
}