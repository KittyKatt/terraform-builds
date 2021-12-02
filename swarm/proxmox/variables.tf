variable "smbusername" {
  type      = string
  sensitive = true
}
variable "smbpassword" {
  type      = string
  sensitive = true
}
variable "smbdomain" {
  type      = string
  sensitive = true
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

locals {
  primary_node_name = "tyr2"
  node_names        = toset([ 
    "oghma2",
    "grumbar2",
    "helm2",
    "tymora2",
    "deneir2"
  ])
}