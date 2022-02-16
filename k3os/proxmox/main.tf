module "cluster" {
  source = "./modules/k3s-cluster"

  pve_user      = var.pve_user
  pve_password  = var.pve_password
  proxmox_hosts = var.proxmox_hosts
}

module "applications" {
  source = "./modules/k3s-apps"

  depends_on = [ module.cluster ]
}