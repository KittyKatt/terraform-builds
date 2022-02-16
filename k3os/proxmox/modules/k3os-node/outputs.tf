output "primary_ipv4" {
  value = proxmox_vm_qemu.k3s_node.default_ipv4_address
}