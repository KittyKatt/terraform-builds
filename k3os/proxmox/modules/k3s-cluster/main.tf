locals {
  qemu_guest_agent = {
    path    = "/etc/conf.d/qemu-guest-agent"
    content = "GA_PATH=\"/dev/vport1p1\""
  }
  kubeconfig = replace(data.remote_file.kubeconfig.content, "127.0.0.1", "${module.k3s_primary.primary_ipv4}")
  kubeconfig_main = pathexpand("~/.kubeconfigs/${module.k3s_primary.name}-config")
}

data "http" "wait_for_cluster" {
  url      = format("%s/readyz", local.control_plane_url)
  insecure = true
  timeout  = 300

  request_headers = {
    "Authorization" = "Bearer ${local.k8s_admin_token}"
  }

  depends_on = [
    module.k3s_node,
    module.k3s_primary
  ]
}