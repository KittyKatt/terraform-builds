resource "kubernetes_namespace" "metallb" {
  metadata {
    name = "metallb-system"
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

resource "kubernetes_config_map" "layer2_configuration" {
  metadata {
    name      = "config"
    namespace = kubernetes_namespace.metallb.metadata[0].name
  }
  data = {
    config = templatefile("${path.module}/conf/values/metallb.yml", {
                ip_range_lower_boundary = var.ip_range_lower_boundary,
                ip_range_upper_boundary = var.ip_range_upper_boundary 
              })
  }
  depends_on = [
    kubernetes_namespace.metallb
  ]

  provider = kubernetes.lb
}

resource "helm_release" "metallb" {
  name             = "metallb"
  repository       = "https://metallb.github.io/metallb"
  chart            = "metallb"
  version          = "0.10.2"
  namespace        = kubernetes_namespace.metallb.metadata[0].name
  create_namespace = false
  cleanup_on_fail  = true

  values = [ "existingConfigMap: config" ]

  depends_on = [
    kubernetes_config_map.layer2_configuration
  ]

  provider = helm.lb
}