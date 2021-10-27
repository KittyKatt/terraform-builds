module "k3s_node" {
  depends_on = [ module.k3s_primary ]
  source = "../k3os-node"

  for_each = local.node_names

  name           = each.key
  cpu_n          = lookup(var.node_configs[each.key],"cpu_n")
  mem_n          = lookup(var.node_configs[each.key],"mem_n")
  ip             = lookup(var.node_configs[each.key],"ip")
  macaddr        = lookup(var.node_configs[each.key],"macaddr")
  disk_size      = data.vsphere_virtual_machine.template_pre.disks.0.size
  control_plane  = false
  k3s_server_url = local.control_plane_url
  k3s_token      = local.node_token

  k3os_write_files = [
    local.qemu_guest_agent
  ]
}