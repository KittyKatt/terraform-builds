# Input variables from environment variables
variable "smbusername" {
  type = string
  sensitive = true
}
variable "smbpassword" {
  type = string
  sensitive = true
}
variable "smbdomain" {
  type = string
  sensitive = true
}

variable "proxmox_hosts" {
  type    = list
  default = []
}
variable "pm_password" {
  type = string
  sensitive = true
}
variable "pm_user" {
  type = string
  sensitive = true
}
variable "pm_url" {
  type = string
  sensitive = true
}
variable "pve_host" {
  type = string
  sensitive = true
}
variable "pve_user" {
  type = string
  sensitive = true
}
variable "pve_password" {
  type = string
  sensitive = true
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
  type    = string
  default = null
}
variable "manager" {
  type    = bool
  default = false
}

variable "vm_cpu_n" {
  type    = string
  default = null
}
variable "vm_mem_n" {
  type    = string
  default = null
}
variable "vm_ip_addr" {
  type    = string
  default = null
}
variable "vm_ceph_ip" {
  type    = string
  default = null
}
variable "vm_job" {
  type    = string
  default = null
}