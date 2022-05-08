module "k3s_primary" {
  source = "../k3os-cluster-node"

  for_each = {for vm in var.node_configs: vm.name => vm if vm.primary == true}

  name           = "${each.value.name}"
  cpu_n          = "${each.value.cpu_n}"
  mem_n          = "${each.value.mem_n}"
  macaddr        = "${each.value.macaddr}"
  control_plane  = true
  k3s_server_url = "" # primary can omit this
  k3s_token      = local.node_token
  k3s_args       = [
    "--cluster-init",
    "--disable=servicelb",
    "--disable=traefik",
    "--tls-san=${var.kubeapi_lb_ip}",
    "--tls-san=${each.value.ipaddr}",
    "--kube-apiserver-arg=token-auth-file=${local.k8s_token_file.path}",
  ]

  pve_user        = var.pve_user
  pve_password    = var.pve_password

  proxmox_hosts   = var.proxmox_hosts
  proxmox_template = var.proxmox_template

  k3os_write_files = [
    local.k8s_token_file,
    local.qemu_guest_agent
  ]
}

locals {
  control_plane_url = "https://[${module.k3s_primary[local.primary_node[0]].primary_ipv4}]:6443"
}
