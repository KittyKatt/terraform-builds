locals {
  primary_node_ip = lookup(var.node_configs[var.primary_node_name],"ip")
  primary_node_mac = lookup(var.node_configs[var.primary_node_name],"macaddr")
}
locals {
  primary_node_mac_formatted = replace(local.primary_node_mac, ":", "")
}

module "k3s_primary" {
  source = "../k3os-node"
  
  name           = var.primary_node_name
  cpu_n          = lookup(var.node_configs[var.primary_node_name],"cpu_n")
  mem_n          = lookup(var.node_configs[var.primary_node_name],"mem_n")
  ip             = lookup(var.node_configs[var.primary_node_name],"ip")
  macaddr        = lookup(var.node_configs[var.primary_node_name],"macaddr")
  disk_size      = data.vsphere_virtual_machine.template_pre.disks.0.size
  control_plane  = true
  k3s_server_url = "" # primary can omit this
  k3s_token      = local.node_token
  k3s_args       = [
    "--disable=servicelb",
    "--disable=traefik",
    "--kube-apiserver-arg=token-auth-file=${local.k8s_token_file.path}",
  ]

  k3os_write_files = [
    local.k8s_token_file,
    local.qemu_guest_agent
    #{
    #  path = "/var/lib/connman/ethernet_${local.primary_node_mac_formatted}_cable/settings"
    #  content = "[service_eth0]\nName=Wired\nType=ethernet\nMAC=${local.primary_node_mac}\nIPv4=${local.primary_node_ip}/255.255.255.0/10.1.10.1\nNameservers=10.1.10.58,10.1.10.1"
    #}
  ]
}

locals {
  control_plane_url = "https://[${module.k3s_primary.primary_ipv4}]:6443"
}

output "control_plane_address" {
  value = module.k3s_primary.primary_ipv4
}

output "control_plane_url" {
  value = local.control_plane_url
}