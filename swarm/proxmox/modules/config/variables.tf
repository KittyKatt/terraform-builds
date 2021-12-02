variable "ssh_ids" {
  type = list
}
variable "ssh_keys" {
  type = list
}
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
    address     = string
    gateway     = string
    subnet      = string
    nameservers = list(string)
    domain      = string
  })
  default = {
    config      = null
    address     = null
    gateway     = null
    subnet      = null
    nameservers = null
    domain      = null
  }
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