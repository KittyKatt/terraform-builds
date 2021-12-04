terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.8.0"
    }
  }
}

module "primary" {
  source       = "../node"
  manager      = true
  name         = var.primary_node_name
  vm_cpu_n     = lookup(var.configuration[var.primary_node_name],"cpus")
  vm_mem_n     = lookup(var.configuration[var.primary_node_name],"memory")
  vm_ip_addr   = lookup(var.configuration[var.primary_node_name],"ip")
  vm_job       = lookup(var.configuration[var.primary_node_name],"job")
  smbpassword  = var.smbpassword
  smbusername  = var.smbusername
  smbdomain    = var.smbdomain
  pve_user     = var.pve_user
  pve_host     = var.pve_host
  pve_password = var.pve_password
  pm_user      = var.pm_user
  pm_password  = var.pm_password
  pm_url       = var.pm_url
}

module "workers" {
  depends_on   = [module.primary]
  source       = "../node"
  for_each     = var.node_names
  name         = each.key
  vm_cpu_n     = lookup(var.configuration[each.key],"cpus")
  vm_mem_n     = lookup(var.configuration[each.key],"memory")
  vm_ip_addr   = lookup(var.configuration[each.key],"ip")
  vm_job       = lookup(var.configuration[each.key],"job")
  smbpassword  = var.smbpassword
  smbusername  = var.smbusername
  smbdomain    = var.smbdomain
  pve_user     = var.pve_user
  pve_host     = var.pve_host
  pve_password = var.pve_password
  pm_user      = var.pm_user
  pm_password  = var.pm_password
  pm_url       = var.pm_url
}

output "manager-address" {
  value = {
    (var.primary_node_name) = module.primary.primary_ipv4
  }
}
output "node-address" {
  value = { for vm in var.node_names : vm => module.workers[vm].primary_ipv4 }
}
output "node-configs" {
  value = var.configuration
}