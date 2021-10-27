variable "vsphere_datacenter" {
    type = string
    default = "Datacenter"
}
variable "vsphere_virtual_machine_template" {
    type = string
    default = "k3os-packer-v1.21.5+k3s2"
}

variable "primary_node_name" {
  type    = string
  default = "moradin"
}

locals {
  gateway     = "10.1.10.1"
  netmask     = "255.255.255.0"
  nameservers = "10.1.10.58,10.1.10.1"
}

locals {
  node_names = toset([
    "dumathoin",
    "abbathor"
  ])
}

variable "node_configs" {
  type = map
  default = {
    moradin = {
      name    = "moradin"
      ip      = "10.1.10.41"
      macaddr = "ce:59:af:c2:b1:f4"
      cpu_n   = "2"
      mem_n   = "2048"
    },
    dumathoin = {
      name    = "dumathoin"
      ip      = "10.1.10.42"
      macaddr = "de:0c:63:e9:df:bb"
      cpu_n   = "2"
      mem_n   = "2048"
    },
    abbathor = {
      name    = "abbathor"
      ip      = "10.1.10.43"
      macaddr = "90:24:52:8f:68:b7"
      cpu_n   = "2"
      mem_n   = "2048"
    }
  }
}

#locals {
#  ipconfig_file = flatten([
#    for config in var.node_configs: {
#        path = "/var/lib/connman/default.config"
#        content = "[service_eth0]\nName=Wired\nType=ethernet\nMAC=config.macaddr\nIPv4=config.ip/255.255.255.0/10.1.10.1\nNameservers=10.1.10.58,10.1.10.1"
#      }
#  ])
#}

#output "ipconfig_file" {
#  value = local.ipconfig_file[*].content
#}