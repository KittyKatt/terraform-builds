provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

module "cluster" {
  source = "./modules/k3s-cluster"
}

output "k8s_api_token" {
  value     = module.cluster.k8s_api_token
  sensitive = true
}
output "control_plane_url" {
  value     = module.cluster.control_plane_url
}