resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "ingress-nginx"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels
    ]
  }
}

resource "helm_release" "nginx" {
  name            = "nginx"
  repository      = "https://helm.nginx.com/stable"
  chart           = "nginx-ingress"
  #version        = "6.0.1"
  namespace       = kubernetes_namespace.nginx.metadata[0].name
  wait_for_jobs   = true
  wait            = false
  cleanup_on_fail = true
  # Set service kind as daemonset
  set {
    name  = "controller.kind"
    value = "daemonset"
  }
  # Set service type as LoadBalancer
  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
  depends_on = [
    helm_release.metallb,
    helm_release.external-dns-freeipa
  ]
}