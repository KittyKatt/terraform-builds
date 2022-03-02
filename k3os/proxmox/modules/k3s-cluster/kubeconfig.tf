resource "time_sleep" "wait_for_k3s" {
  depends_on = [ module.k3s_primary ]
  create_duration = "10s"
}

data "remote_file" "kubeconfig" {
  depends_on = [ time_sleep.wait_for_k3s ]
  conn {
    host = "${module.k3s_primary.primary_ipv4}"
    user = "rancher"
    agent = true
  }
  path = "/etc/rancher/k3s/k3s.yaml"
}

resource "local_file" "kubeconfig" {
  depends_on = [ data.remote_file.kubeconfig ]
  content = replace(data.remote_file.kubeconfig.content, "127.0.0.1", "${module.k3s_primary.primary_ipv4}")
  filename = pathexpand("~/.kubeconfigs/${module.k3s_primary.name}-config")
}

resource "local_file" "localkubeconfig" {
  depends_on = [ data.remote_file.kubeconfig ]
  content = replace(data.remote_file.kubeconfig.content, "127.0.0.1", "${module.k3s_primary.primary_ipv4}")
  filename = "${path.root}/kubeconfig"
}