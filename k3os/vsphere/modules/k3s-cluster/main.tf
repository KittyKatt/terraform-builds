locals {
  qemu_guest_agent = {
    path    = "/etc/conf.d/qemu-guest-agent"
    content = "# Blank File"
  }
}

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}
data "vsphere_virtual_machine" "template_pre" {
  name          = var.vsphere_virtual_machine_template
  datacenter_id = data.vsphere_datacenter.dc.id
}