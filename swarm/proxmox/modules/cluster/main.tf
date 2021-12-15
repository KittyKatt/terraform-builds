module "primary" {
  source         = "../node"
  manager        = true
  name           = var.primary_node_name
  network_config = var.network_config
  mount_config   = var.mount_config
  vm_cpu_n       = lookup(var.configuration[var.primary_node_name],"cpus")
  vm_mem_n       = lookup(var.configuration[var.primary_node_name],"memory")
  vm_ip_addr     = lookup(var.configuration[var.primary_node_name],"ip")
  vm_ceph_ip     = lookup(var.configuration[var.primary_node_name],"ceph")
  vm_job         = lookup(var.configuration[var.primary_node_name],"job")
  ssh_keys       = var.ssh_keys
  ssh_ids        = var.ssh_ids
  smbpassword    = var.smbpassword
  smbusername    = var.smbusername
  smbdomain      = var.smbdomain
  proxmox_hosts  = var.proxmox_hosts
  pve_user       = var.pve_user
  pve_host       = var.pve_host
  pve_password   = var.pve_password
  pm_user        = var.pm_user
  pm_password    = var.pm_password
  pm_url         = var.pm_url
}

module "workers" {
  depends_on     = [module.primary]
  source         = "../node"
  for_each       = var.node_names
  name           = each.key
  network_config = var.network_config
  mount_config   = var.mount_config
  vm_cpu_n       = lookup(var.configuration[each.key],"cpus")
  vm_mem_n       = lookup(var.configuration[each.key],"memory")
  vm_ip_addr     = lookup(var.configuration[each.key],"ip")
  vm_ceph_ip     = lookup(var.configuration[each.key],"ceph")
  vm_job         = lookup(var.configuration[each.key],"job")
  ssh_keys       = var.ssh_keys
  ssh_ids        = var.ssh_ids
  smbpassword    = var.smbpassword
  smbusername    = var.smbusername
  smbdomain      = var.smbdomain
  proxmox_hosts  = var.proxmox_hosts
  pve_user       = var.pve_user
  pve_host       = var.pve_host
  pve_password   = var.pve_password
  pm_user        = var.pm_user
  pm_password    = var.pm_password
  pm_url         = var.pm_url
}

output "manager-address" {
  value = {
    (var.primary_node_name) = module.primary.primary_ipv4
  }
}
output "node-address" {
  value = { for vm in var.node_names : vm => module.workers[vm].primary_ipv4 }
}