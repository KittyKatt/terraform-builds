module "cluster" {
  source = "./modules/k3s-cluster"

  pve_user          = var.pve_user
  pve_password      = var.pve_password
  proxmox_hosts     = var.proxmox_hosts
  node_configs      = var.node_configs
  primary_node_name = var.primary_node_name
  node_names        = var.node_names
}

resource "time_sleep" "wait_for_k3s" {
  depends_on = [ module.cluster ]
  create_duration = "10s"
}

module "applications" {
  source = "./modules/k3s-apps"

  depends_on = [ time_sleep.wait_for_k3s ]
}