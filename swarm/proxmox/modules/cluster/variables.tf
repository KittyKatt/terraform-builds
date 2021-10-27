variable "node_names" {
    type = set(string)
    default = null
}
variable "primary_node_name" {
    type = string
    default = null
}
variable "smbusername" {
    type = string
    sensitive = true
    default = null
}
variable "smbpassword" {
    type = string
    sensitive = true
    default = null
}