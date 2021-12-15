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

variable "mount_config" {
  type = list(object({
    source      = string,
    destination = string,
    type        = string,
    options     = string
  }))
}
variable "network_config" {
  type = object({
    config      = string
    gateway     = string
    subnet      = string
    nameservers = list(string)
    domain      = string
    ceph_subnet = string
  })
}
variable "ssh_keys" {
  type = list
  default = []
}
variable "ssh_ids" {
  type = list
  default = []
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

variable "proxmox_hosts" {
  type    = list
  default = []
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