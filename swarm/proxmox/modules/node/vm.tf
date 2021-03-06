terraform {
  experiments = [module_variable_optional_attrs]
}

resource "random_shuffle" "target_node" {
  input        = var.proxmox_hosts
  result_count = 1
}

resource "proxmox_vm_qemu" "swarm_node" {
  depends_on                   = [module.configuration]
  name                         = var.name
  target_node                  = random_shuffle.target_node.result[0]
  cores                        = var.vm_cpu_n
  sockets                      = 1
  memory                       = var.vm_mem_n
  clone                        = "fedora-cloud"
  full_clone                   = false
  scsihw                       = "virtio-scsi-pci"
  boot                         = "c"
  bootdisk                     = "scsi0"
  onboot                       = true
  agent                        = 1
  #hastate                      = "started"
  #hagroup                      = "Production"
  os_type                      = "cloud-init"
  cloudinit_cdrom_storage      = "ISO"
  cicustom                     = "user=ISO:snippets/${var.name}-config.yml,meta=ISO:snippets/${var.name}-meta.yml"
  nameserver                   = "${var.network_config.nameservers[0]}"
  searchdomain                 = "${var.network_config.domain}"
  ipconfig0                    = "ip=${var.vm_ip_addr}/${var.network_config.subnet},gw=${var.network_config.gateway}"
  ipconfig1                    = "ip=${var.vm_ceph_ip}/${var.network_config.ceph_subnet}"
  #force_recreate_on_change_of = sha1(local.user_data_yaml)
  #define_connection_info      = false
  network {
    model   = "virtio"
    bridge  = "vmbr1"
    tag     = 10
  }
  network {
    model   = "virtio"
    bridge  = "vmbr5"
  }
  disk {
    type    = "scsi"
    storage = "VMDisks"
    size    = "25G"
    format  = "qcow2"
  }
  disk {
    type    = "scsi"
    storage = "VMDisks"
    size    = "250G"
    format  = "qcow2"
  }
  lifecycle {
    ignore_changes = [
      full_clone,
      disk["size"],
      disk["type"]
    ]
  }
}

output "primary_ipv4" {
  value = proxmox_vm_qemu.swarm_node.default_ipv4_address
}