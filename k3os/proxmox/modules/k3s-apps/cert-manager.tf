resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
  
  depends_on = [
    var.k3s_cluster_created
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

  values = [
    file("${path.module}/conf/values/cert-manager.yml"),
  ]

  depends_on = [
    helm_release.nginx-ingress,
    helm_release.metallb
  ]
}