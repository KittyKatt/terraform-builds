variable "vcenter_server" {
  type  = string
}
variable "vcenter_host" {
  type = string
}
variable "vcenter_username" {
  type = string
  sensitive = true
}
variable "vcenter_password" {
  type = string
  sensitive = true
}
variable "vcenter_datastore" {
  type = string
}
variable "vcenter_folder" {
  type = string
}
variable "vcenter_network" {
  type = string
}
variable "vcenter_iso_path" {
  type = string
}

#variable "config_url" {
#  type = string
#}
variable "k3os_version" {
  type = string
}

# variable "ssh_username" {
#   type = string
# }
# variable "ssh_password" {
#   type = string
#   sensitive = true
# }
