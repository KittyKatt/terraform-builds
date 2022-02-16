module "cluster" {
  source = "./modules/k3s-cluster"

  pve_user      = var.pve_user
  pve_password  = var.pve_password
  proxmox_hosts = var.proxmox_hosts
}

output "k8s_api_token" {
  value     = module.cluster.k8s_api_token
  sensitive = true
}
output "control_plane_url" {
  value     = module.cluster.control_plane_url
}