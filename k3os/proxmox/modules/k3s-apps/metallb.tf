resource "kubernetes_namespace" "metallb_system" {
  metadata {
    name = "metallb-system"
  }
}

resource "kubernetes_config_map" "layer2_configuration" {
  metadata {
    name      = "config"
    namespace = "metallb-system"
  }
  data = {
    config = templatefile("${path.module}/values/metallb.yml", {
                ip_range_lower_boundary = var.ip_range_lower_boundary,
                ip_range_upper_boundary = var.ip_range_upper_boundary 
              })
  }
  depends_on = [
    kubernetes_namespace.metallb_system
  ]
}

resource "helm_release" "metallb" {
  name             = "metallb"
  repository       = "https://metallb.github.io/metallb"
  chart            = "metallb"
  version          = "0.10.2"
  namespace        = "metallb-system"
  create_namespace = false
  cleanup_on_fail  = true

  values = [ "existingConfigMap: config" ]

  # values = [
  #   "templatefile(${path.module}/values/metallb.yml, {
  #               ip_range_lower_boundary = var.ip_range_lower_boundary,
  #               ip_range_upper_boundary = var.ip_range_upper_boundary 
  #             })"
  # ]

  depends_on = [
    kubernetes_config_map.layer2_configuration
  ]
}

# resource "kubectl_manifest" "metallb_configmap" {
#   yaml_body = templatefile("${path.module}/values/metallb.yml", {
#                 ip_range_lower_boundary = var.ip_range_lower_boundary
#               })

#   depends_on = [helm_release.metallb]
# }
