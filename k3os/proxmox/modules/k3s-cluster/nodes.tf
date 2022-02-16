module "k3s_node" {
  depends_on = [ module.k3s_primary ]
  source = "../k3os-node"

  for_each = local.node_names

  name           = each.key
  cpu_n          = lookup(var.node_configs[each.key],"cpu_n")
  mem_n          = lookup(var.node_configs[each.key],"mem_n")
  ip             = lookup(var.node_configs[each.key],"ip")
  macaddr        = lookup(var.node_configs[each.key],"macaddr")
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