variable "vsphere_datacenter" {
    type = string
    default = "Datacenter"
}
variable "vsphere_datastore" {
    type = string
    default = "datastore1"
}
variable "vsphere_network" {
    type = string
    default = "Infrastructure"
}
variable "vsphere_virtual_machine_template" {
    type = string
    default = "k3os-packer-v1.21.5+k3s2"
}
variable "vsphere_resource_pool" {
    type = string
    default = "Resources"
}
variable "vsphere_host" {
    type = string
    default = "toril.kittykatt.co"
}

variable "disk_size" {
    type = string
}