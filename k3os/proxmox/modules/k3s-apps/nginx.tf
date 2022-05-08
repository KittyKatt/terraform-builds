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

  depends_on = [
    var.k3s_cluster_created,
    var.kubeapi_lb_ip
  ]

  provider = kubernetes.lb
}

resource "helm_release" "nginx" {
  name            = "nginx"
  repository      = "https://kubernetes.github.io/ingress-nginx"
  chart           = "ingress-nginx"
  #version        = "6.0.1"
  namespace       = kubernetes_namespace.nginx.metadata[0].name
  wait_for_jobs   = true
  wait            = false
  cleanup_on_fail = true
  # Set service kind as daemonset
  # set {
  #   name  = "controller.kind"
  #   value = "daemonset"
  # }
  # # Set service type as LoadBalancer
  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  # Expose port 22 for Gitlab SSH
  # set {
  #   name = "tcp.22"
  #   value = "gitlab/gitlab-gitlab-shell:22"
  # }

  depends_on = [
    helm_release.metallb
  ]

  provider = helm.lb
}
