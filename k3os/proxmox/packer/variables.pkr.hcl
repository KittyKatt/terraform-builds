variable "iso_checksum" {
  type    = string
}
variable "iso_path" {
  type    = string
}
variable "k3os_version" {
  type    = string
}
variable "storage_pool" {
  type    = string
}
variable "ha_group" {
  type    = string
}
variable "api_url" {
  type    = string
}
variable "node" {
  type    = string
}
variable "api_username" {
  type      = string
  sensitive = true
}
variable "api_password" {
  type    = string
  sensitive = true
}


#variable "config_url" {
#  type = string
#}

# variable "ssh_username" {
#   type = string
# }
# variable "ssh_password" {
#   type = string
#   sensitive = true
# }
