output "workspace" {
  value = "${terraform.workspace}"
}
output "control_plane_url" {
  value     = module.load-balancer.control_plane_url
}
output "lb_ip" {
  value = module.load-balancer.kubeapi_lb_ip
}
