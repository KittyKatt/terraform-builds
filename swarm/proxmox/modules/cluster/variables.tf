variable "node_names" {
  type    = set(string)
  default = null
}
variable "primary_node_name" {
  type    = string
  default = null
}
variable "configuration" {
  type = map(map(string))
}

variable "smbusername" {
  type      = string
  sensitive = true
  default   = null
}
variable "smbpassword" {
  type      = string
  sensitive = true
  default   = null
}
variable "smbdomain" {
  type      = string
  sensitive = true
  default   = null
}

variable "pm_password" {
  type      = string
  sensitive = true
}
variable "pm_user" {
  type      = string
  sensitive = true
}
variable "pm_url" {
  type      = string
  sensitive = true
}
variable "pve_host" {
  type      = string
  sensitive = true
}
variable "pve_user" {
  type      = string
  sensitive = true
}
variable "pve_password" {
  type      = string
  sensitive = true
}