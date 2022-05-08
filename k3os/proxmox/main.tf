module "cluster" {
  source = "./modules/k3os-cluster"

  pve_user         = var.pve_user
  pve_password     = var.pve_password
  proxmox_hosts    = local.config.proxmox_hosts
  proxmox_template = local.config.proxmox_template
  node_configs     = local.config.node_configs
  kubeapi_lb_ip    = local.config.kubeapi_lb_ip
}

module "load-balancer" {
  source = "./modules/k3s-lb"

  k3s_control_plane_created = module.cluster.k3s_control_plane_created
  kubeapi_lb_ip             = local.config.kubeapi_lb_ip

  providers = {
    helm.lb_bootstrap       = helm.lb_bootstrap
    helm.lb                 = helm.lb
    kubernetes.lb_bootstrap = kubernetes.lb_bootstrap
    kubernetes.lb           = kubernetes.lb
  }
}

module "applications" {
  source = "./modules/k3s-apps"

  k3s_cluster_created     = module.cluster.k3s_cluster_created
  kubeapi_lb_ip           = module.load-balancer.kubeapi_lb_ip
  domain_name             = local.config.domain_name
  acme_email              = var.acme_email
  api_token               = var.api_token
  ipa_fqdn                = var.ipa_fqdn
  ipa_dnssec_key          = var.ipa_dnssec_key
  ip_range_lower_boundary = local.config.ip_range_lower_boundary
  ip_range_upper_boundary = local.config.ip_range_upper_boundary

  providers = {
    kubernetes.lb = kubernetes.lb
    helm.lb       = helm.lb
  }
}

# module "rancher" {
#   source = "./modules/rancher"

#   rancher_bootstrap_password = var.rancher_bootstrap_password
#   rancher_created            = module.applications.rancher_created

#   providers = {
#     rancher2.bootstrap = rancher2.bootstrap
#     rancher2.admin     = rancher2.admin
#   }
# }
