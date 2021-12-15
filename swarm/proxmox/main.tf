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
  proxmox_hosts     = var.proxmox_hosts
  pve_user          = var.pve_user
  pve_host          = var.pve_host
  pve_password      = var.pve_password
  pm_user           = var.pm_user
  pm_password       = var.pm_password
  pm_url            = var.pm_url
}

resource "time_sleep" "wait_30_seconds" {
  depends_on      = [module.cluster]
  create_duration = "10s"
}


module "provision" {
  depends_on     = [time_sleep.wait_30_seconds]
  source         = "./modules/provision"
  manager-config = module.cluster.manager-address
  node-configs   = local.configuration
}

output "node-address" {
  value = merge(module.cluster.manager-address, module.cluster.node-address)
}