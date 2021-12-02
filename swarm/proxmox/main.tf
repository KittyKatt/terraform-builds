module "cluster" {
  source            = "./modules/cluster"
  primary_node_name = local.primary_node_name
  node_names        = local.node_names
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

# module "provision" {
#   depends_on       = [module.cluster]
#   source           = "./modules/provision"
#   configurations   = module.cluster.node-configs
#   manager-hostname = local.primary_node_name
#   manager-ip       = module.primary.primary_ipv4
#   node-hostname    = local.node_names
#   node-ip          = module.cluster.vm-address
# }