resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
  depends_on = [
    helm_release.nginx-ingress
  ]
}

resource "helm_release" "cert-manager" {
  name             = "cm"
  namespace        = kubernetes_namespace.cert-manager.metadata[0].name
  create_namespace = false
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  version          = "v1.7.1"
  wait_for_jobs    = true
  cleanup_on_fail  = true

  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [
    kubernetes_namespace.cert-manager
  ]
}

