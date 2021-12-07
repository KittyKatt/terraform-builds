module "cluster" {
  source            = "./modules/cluster"
  primary_node_name = local.primary_node_name
  node_names        = local.node_names
  configuration     = local.configuration
  network_config    = var.network_config
  mount_config      = var.mount_config
  ssh_keys          = var.ssh_keys
  ssh_ids           = var.ssh_ids
  smbusername       = var.smbusername
  smbpassword       = var.smbpassword
  smbdomain         = var.smbdomain
  pve_user          = var.pve_user
  pve_host          = var.pve_host
  pve_password      = var.pve_password
  pm_user           = var.pm_user
  pm_password       = var.pm_password
  pm_url            = var.pm_url
}

module "provision" {
  depends_on     = [module.cluster]
  source         = "./modules/provision"
  manager-config = module.cluster.manager-address
  node-configs   = local.configuration
}

# output "configuration" {
#   value = local.configuration
# }

output "node-address" {
  value = merge(module.cluster.manager-address, module.cluster.node-address)
}