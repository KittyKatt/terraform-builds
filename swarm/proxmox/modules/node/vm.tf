
terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.8.0"
    }
  }
}

terraform {
  experiments = [module_variable_optional_attrs]
}


resource "proxmox_vm_qemu" "swarm_node" {
  depends_on                   = [module.configuration]
  name                         = var.name
  target_node                  = "toril"
  cores                        = var.vm_cpu_n
  sockets                      = 1
  memory                       = var.vm_mem_n
  clone                        = "fedora-cloud"
  full_clone                   = false
  scsihw                       = "virtio-scsi-pci"
  boot                         = "c"
  bootdisk                     = "virtio0"
  onboot                       = true
  agent                        = 1
  os_type                      = "cloud-init"
  cloudinit_cdrom_storage      = "ISO"
  cicustom                     = "user=ISO:snippets/${var.name}-config.yml,meta=ISO:snippets/${var.name}-meta.yml"
  nameserver                   = "${local.network.nameservers[0]}"
  searchdomain                 = "${local.network.domain}"
  ipconfig0                    = "ip=${local.network.address}/${local.network.subnet},gw=${local.network.gateway}"
  #force_recreate_on_change_of = sha1(local.user_data_yaml)
  #define_connection_info      = false
  network {
    model   = "virtio"
    bridge  = "vmbr1"
    tag     = 10
  }
  disk {
    type    = "virtio"
    storage = "VMDisks"
    size    = "200G"
    format  = "qcow2"
  }
  lifecycle {
    ignore_changes = [
      full_clone
    ]
  }
}

output "primary_ipv4" {
  value = proxmox_vm_qemu.swarm_node.default_ipv4_address
}