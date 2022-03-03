data "remote_file" "kubeconfig" {
  depends_on = [ data.http.wait_for_cluster ]
  conn {
    host = "${module.k3s_primary.primary_ipv4}"
    user = "rancher"
    agent = true
  }
  path = "/etc/rancher/k3s/k3s.yaml"
}

resource "local_file" "kubeconfig" {
  content = local.kubeconfig
  filename = local.kubeconfig_main
}

# resource "local_file" "localkubeconfig" {
#   content = replace(data.remote_file.kubeconfig.content, "127.0.0.1", "${module.k3s_primary.primary_ipv4}")
#   filename = local.kubeconfig_local
# }