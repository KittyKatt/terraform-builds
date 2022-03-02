module "k3s_primary" {
  source = "../k3os-node"

  name           = var.node_configs[0].name
  cpu_n          = var.node_configs[0].cpu_n
  mem_n          = var.node_configs[0].mem_n
  macaddr        = var.node_configs[0].macaddr
  control_plane  = true
  k3s_server_url = "" # primary can omit this
  k3s_token      = local.node_token
  k3s_args       = [
    "--disable=servicelb",
    "--disable=traefik",
    "--kube-apiserver-arg=token-auth-file=${local.k8s_token_file.path}",
  ]

  pve_user        = var.pve_user
  pve_password    = var.pve_password

  proxmox_hosts   = var.proxmox_hosts

  k3os_write_files = [
    local.k8s_token_file,
    local.qemu_guest_agent
  ]
}

locals {
  control_plane_url = "https://[${module.k3s_primary.primary_ipv4}]:6443"
}