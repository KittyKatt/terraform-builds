variable "config_url" {
  type    = string
  default = "http://10.1.10.150:8080/k3os-basic.yml"
}

variable "iso_checksum" {
  type    = string
  default = "85f186533de514445c2dfeadfc6f101b6c63f1c99ec2b1f273a5c7de2d736974"
}

variable "k3os_version" {
  type    = string
  default = "v0.22.2-k3s2r0"
}

variable "storage_pool" {
  type    = string
  default = "local-lvm"
}

locals {
  boot_command_pre = ["<wait>", "<tab>", "<down>", "<wait>", "e", "<down>", "<down>", "<down>", "<down>", "<down>", "<down>", "<end>"]
  boot_command_args = [
    " ", "k3os.install.debug=true"
  ]
  boot_command_args_proxmox = [
    " ", "k3os.install.device=/dev/vda",
    " ", "k3os.install.power_off=true",
    " ", "k3os.install.config_url=${var.config_url}"
  ]
  boot_command_post = [
    "<F10>",
    # packer attempts to shut the VM down directly after booting
    # but we need to wait for it to run the installation first
    "<wait60s>"
  ]
}

source "proxmox-iso" "proxmox" {
  proxmox_url  = "https://pve-storage.kittykatt.co:8006/api2/json"
  insecure_skip_tls_verify = true
  node         = "pve-storage"
  communicator = "none"
  qemu_agent   = true
  boot_command = concat(local.boot_command_pre, local.boot_command_args, local.boot_command_args_proxmox, local.boot_command_post)
  boot_wait    = "5s"

  template_name        = "k3os-${var.k3os_version}"
  template_description = <<EOF
    k3os ${var.k3os_version}
    generated on ${timestamp()}"
  EOF

  # It's not feasible to upload the ISO to Proxmox during the packer run.
  # Please upload the iso to Proxmox manually when upgrading to a new version.
  iso_file     = "ISO:iso/k3os-amd64.iso"
  iso_checksum = "sha256:${var.iso_checksum}"

  os          = "l26"
  cpu_type    = "kvm64"
  cores       = "2"
  sockets     = "1"
  memory      = "2048"
  cloud_init  = false
  unmount_iso = true

  scsi_controller = "virtio-scsi-pci"

  disks {
    disk_size         = "35G"
    format            = "raw"
    storage_pool      = var.storage_pool
    storage_pool_type = "lvm"
    type              = "virtio"
  }

  network_adapters {
    model    = "virtio"
    bridge   = "vmbr1"
    vlan_tag = "10"
  }
}

build {
  sources = ["source.proxmox-iso.proxmox"]
}