variable "vsphere_server" {
    type = string
    default = "vcenter.kittykatt.co"
}
variable "vsphere_user" {
    type = string
}
variable "vsphere_password" {
    type = string
    sensitive = true
}