resource "proxmox_vm_qemu" "k3s_node" {
  depends_on = [module.user_data]

  name       = var.name
  target_node = random_shuffle.target_host.result[0]

  cores   = var.cpu_n
  sockets = 1
  memory  = var.mem_n

  clone = "k3os"
  full_clone = false

  network {
    model   = "virtio"
    macaddr = var.macaddr[0]
    bridge  = "vmbr1"
    tag     = 10
  }

  disk {
    type    = "virtio"
    storage = "VMDisks"
    size    = "35G"
  }

  disk {
    type    = "virtio"
    storage = "VMDisks"
    size    = "70G"
  }

  scsihw   = "virtio-scsi-pci"
  boot     = "c"
  bootdisk = "virtio0"

  onboot = true
  agent  = 1

  os_type = "cloud-init"
  cloudinit_cdrom_storage = "ISO"
  cicustom = "user=ISO:snippets/${var.name}-config.yaml"

  force_recreate_on_change_of = sha1(local.user_data_yaml)

  lifecycle {
    ignore_changes = [
      full_clone,
      desc
    ]
  }
}
