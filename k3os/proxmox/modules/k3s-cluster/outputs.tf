output "control_plane_address" {
  value = module.k3s_primary.primary_ipv4
}

output "control_plane_url" {
  value = local.control_plane_url
}

output "k3s_api_token" {
  value     = local.k8s_admin_token
}

output "k3s_cluster_created" {
  value = true
  depends_on = [
    data.http.wait_for_cluster
  ]
}
output "k3s_ca_cert" {
  value = base64decode(yamldecode("${local.kubeconfig}").clusters[0].cluster.certificate-authority-data)
}