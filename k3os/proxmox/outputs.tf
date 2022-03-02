output "workspace" {
  value = "${terraform.workspace}"
}
output "control_plane_url" {
  value     = module.cluster.control_plane_url
}