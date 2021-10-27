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

resource "vsphere_virtual_machine" "k3os_node" {
  name             = var.name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  host_system_id   = data.vsphere_host.host.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.cpu_n
  memory   = var.mem_n
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  #wait_for_guest_net_timeout = 1
  #wait_for_guest_net_routable = false
  wait_for_guest_ip_timeout = 2

  network_interface {
    use_static_mac  = true
    mac_address     = var.macaddr
    network_id      = data.vsphere_network.network.id
    adapter_type    = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label = "disk0"
    size  = var.disk_size
  }

  enable_disk_uuid = "true"

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  extra_config = {
    "disk.EnableUUID" = "TRUE"
    "guestinfo.userdata"          = local.user_data_yaml
    "guestinfo.userdata.encoding" = " "
    "guestinfo.metadata"          = <<-EOT
      { "local-hostname": "${var.name}" }
    EOT
    "guestinfo.metadata.encoding" = " "
  }
}

output "primary_ipv4" {
  value = vsphere_virtual_machine.k3os_node.default_ip_address
}