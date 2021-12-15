variable "manager" {
  type = bool
  default = false
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
variable "name" {
  type = string
}
# variable "ip_address" {
#     type = string
# }
variable "smbuser" {
  type = string
}
variable "smbpass" {
  type      = string
  sensitive = true
}
variable "smbdomain" {
  type      = string
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