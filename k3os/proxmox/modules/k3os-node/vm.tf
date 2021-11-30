
terraform {
  experiments = [module_variable_optional_attrs]
}

variable "name" {
  type = string
}
variable "mem_n" {
  type = string
}
variable "cpu_n" {
  type = string
}


resource "proxmox_vm_qemu" "k3s_node" {
  depends_on = [module.user_data]

  name       = var.name
  target_node = "toril"

  cores   = var.cpu_n
  sockets = 1
  memory  = var.mem_n

  clone = "k3os"
  full_clone = false

  network {
    model   = "virtio"
    macaddr = var.macaddr
    bridge  = "vmbr1"
    tag     = 10
  }

  disk {
    type    = "virtio"
    storage = "VMDisks"
    size    = "35G"
  }

  scsihw   = "virtio-scsi-pci"
  boot     = "c"
  bootdisk = "virtio0"

  onboot = true
  agent  = 1

  os_type = "cloud-init"
  #ipconfig0 = "ip=10.1.10.94/24,gw=10.1.10.1"
  cloudinit_cdrom_storage = "ISO"
  cicustom = "user=ISO:snippets/${var.name}-config.yaml"

  force_recreate_on_change_of = sha1(local.user_data_yaml)

  # define_connection_info = false
  lifecycle {
    ignore_changes = [
      full_clone
    ]
  }
}

output "primary_ipv4" {
  value = proxmox_vm_qemu.k3s_node.default_ipv4_address
}