output "control_plane_url" {
  value = "https://${var.kubeapi_lb_ip}:6443"

  depends_on = [
    null_resource.wait-for-lb-ip
  ]
}

output "kubeapi_lb_ip" {
  value = var.kubeapi_lb_ip

  depends_on = [
    null_resource.wait-for-lb-ip
  ]
}