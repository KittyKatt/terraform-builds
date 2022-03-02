module "k3s_node" {
  depends_on = [ module.k3s_primary ]
  source = "../k3os-node"

  for_each = {for vm in var.node_configs: vm.name => vm if vm.primary != true }
  
  name           = "${each.value.name}"
  cpu_n          = "${each.value.cpu_n}"
  mem_n          = "${each.value.mem_n}"
  macaddr        = "${each.value.macaddr}"
  control_plane  = false
  k3s_server_url = local.control_plane_url
  k3s_token      = local.node_token

  pve_user        = var.pve_user
  pve_password    = var.pve_password

  proxmox_hosts   = var.proxmox_hosts

  k3os_write_files = [
    local.qemu_guest_agent
  ]
}