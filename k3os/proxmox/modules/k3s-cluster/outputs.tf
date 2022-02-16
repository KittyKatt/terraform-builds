output "control_plane_address" {
  value = module.k3s_primary.primary_ipv4
}

output "control_plane_url" {
  value = "https://[${module.k3s_primary.primary_ipv4}]:6443"
}