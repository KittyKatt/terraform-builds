terraform {
  experiments = [module_variable_optional_attrs]
}

locals {
  primary_node        = flatten([
    for vm in var.node_configs: vm.name
    if vm.primary == true
  ])
  qemu_guest_agent    = {
    path    = "/etc/conf.d/qemu-guest-agent"
    content = "GA_PATH=\"/dev/vport1p1\""
  }
  kubeconfig      = replace(data.remote_file.kubeconfig.content, "127.0.0.1", "${module.k3s_primary[local.primary_node[0]].primary_ipv4}")
  kubeconfig_main = pathexpand("~/.kubeconfigs/${module.k3s_primary[local.primary_node[0]].name}-config")
}

data "http" "wait_for_cluster" {
  url      = format("%s/readyz", local.control_plane_url)
  insecure = true
  timeout  = 720

  request_headers = {
    "Authorization" = "Bearer ${local.k8s_admin_token}"
  }

  depends_on = [
    module.k3s_server,
    module.k3s_primary
  ]
}