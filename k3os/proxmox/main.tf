module "cluster" {
  source = "./modules/k3s-cluster"

  pve_user          = var.pve_user
  pve_password      = var.pve_password
  proxmox_hosts     = local.config.proxmox_hosts
  node_configs      = local.config.node_configs
}

module "applications" {
  source = "./modules/k3s-apps"

  k3s_cluster_created     = module.cluster.k3s_cluster_created
  ip_range_lower_boundary = local.config.ip_range_lower_boundary
  ip_range_upper_boundary = local.config.ip_range_upper_boundary
  domain_name             = local.config.domain_name
  acme_email              = var.acme_email
  api_token               = var.api_token
  ipa_fqdn                = var.ipa_fqdn
  ipa_dnssec_key          = var.ipa_dnssec_key
}

module "rancher" {
  source = "./modules/rancher"

  rancher_bootstrap_password = var.rancher_bootstrap_password
  rancher_created            = module.applications.rancher_created

  providers = {
    rancher2.bootstrap = rancher2.bootstrap
    rancher2.admin     = rancher2.admin
  }
}