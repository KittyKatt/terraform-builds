resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "nginx-ingress" {
  name            = "nginx"
  repository      = "https://helm.nginx.com/stable"
  chart           = "nginx-ingress"
  #version        = "6.0.1"
  namespace       = kubernetes_namespace.ingress_nginx.metadata[0].name
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
    helm_release.metallb
  ]
}