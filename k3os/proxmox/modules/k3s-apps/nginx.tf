resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
  }
  depends_on = [
    helm_release.metallb
  ]
}

resource "helm_release" "nginx-ingress" {
  name       = "nginx"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"
  #version   = "6.0.1"
  namespace  = "ingress-nginx"
  wait       = false
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
    kubernetes_namespace.ingress_nginx
  ]
}