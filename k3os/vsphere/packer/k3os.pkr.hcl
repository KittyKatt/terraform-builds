locals {
  boot_command_pre = ["<wait>", "<tab>", "<down>", "<wait>", "e", "<down>", "<down>", "<down>", "<down>", "<down>", "<down>", "<end>"]
  boot_command_args = [
    " ", "k3os.install.silent=true",
    " ", "k3os.install.debug=true"
  ]
  boot_command_args_vsphere = [
    " ", "k3os.install.device=/dev/sda",
    " ", "k3os.install.power_off=true",
    " ", "k3os.install.config_url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/k3os-packer.yml"
  ]
  boot_command_post = [
    "<F10>"
  ]
}

source "vsphere-iso" "k3os" {
  CPUs                  = 2
  RAM                   = 4096
  RAM_reserve_all       = true
  boot_command          = concat(local.boot_command_pre, local.boot_command_args, local.boot_command_args_vsphere, local.boot_command_post)
  boot_wait             = "5s"
  boot_order            = "disk,cdrom"
  communicator          = "none"
  convert_to_template   = "true"
  datastore             = "${var.vcenter_datastore}"
  disable_shutdown      = "true"
  disk_controller_type  = ["pvscsi"]
  folder                = "${var.vcenter_folder}"
  guest_os_type         = "other4xLinux64Guest"
  host                  = "${var.vcenter_host}"
  http_directory        = "config"
  insecure_connection   = "true"
  #ip_wait_timeout       = "60s"
  iso_paths             = ["${var.vcenter_iso_path}"]
  iso_checksum          = "md5:b190e3acb24dfcd07735c690b985bb0c"
  network_adapters {
    network      = "${var.vcenter_network}"
    network_card = "vmxnet3"
  }
  password              = "${var.vcenter_password}"
  #shutdown_command      = "sudo poweroff"
  shutdown_timeout       = "60s"
  #ssh_username          = "${var.ssh_username}"
  #ssh_password          = "${var.ssh_password}"
  storage {
    disk_size             = 35840
    disk_thin_provisioned = true
  }
  username              = "${var.vcenter_username}"
  vcenter_server        = "${var.vcenter_server}"
  vm_name               = "k3os-packer-${var.k3os_version}"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.vsphere-iso.k3os"]

  #provisioner "shell" {
  #  execute_command = "{{ .Vars }} sudo -E sh '{{ .Path }}'"
  #  inline          = ["echo hello world"]
  #}
}
