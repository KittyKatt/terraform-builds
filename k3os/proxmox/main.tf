module "cluster" {
  source = "./modules/k3s-cluster"

  pve_user          = var.pve_user
  pve_password      = var.pve_password
  proxmox_hosts     = var.proxmox_hosts
  node_configs      = var.node_configs
  primary_node_name = var.primary_node_name
  node_names        = var.node_names
}
}

module "applications" {
  source = "./modules/k3s-apps"

  depends_on = [ module.cluster ]
}