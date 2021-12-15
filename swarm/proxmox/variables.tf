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

variable "mount_config" {
  description = "Mount configurations for cloud-config"
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

locals {
  primary_node_name = "tyr"
  node_names        = toset([ 
    "oghma",
    "grumbar",
    "helm",
    "tymora",
    "deneir",
    "gond"
  ])
  configuration = {
    tyr = {
      name    = "tyr"
      primary = true
      cpus    = 4
      memory  = 8192
      role    = "Manager"
      job     = "Light"
      ceph    = "172.18.20.1"
      ip      = "10.1.10.61"
    },
    oghma = {
      name    = "oghma"
      primary = false
      cpus    = 8
      memory  = 16284
      role    = "Manager"
      job     = "Heavy"
      ceph    = "172.18.20.2"
      ip      = "10.1.10.62"
    },
    grumbar = {
      name    = "grumbar"
      primary = false
      cpus    = 4
      memory  = 8192
      role    = "Manager"
      job     = "Light"
      ceph    = "172.18.20.3"
      ip      = "10.1.10.63"
    },
    tymora = {
      name    = "tymora"
      primary = false
      cpus    = 4
      memory  = 8192
      role    = "Worker"
      job     = "Light"
      ceph    = "172.18.20.4"
      ip      = "10.1.10.64"
    },
    deneir = {
      name    = "deneir"
      primary = false
      cpus    = 8
      memory  = 16284
      role    = "Worker"
      job     = "Heavy"
      ceph    = "172.18.20.5"
      ip      = "10.1.10.65"
    },
    helm = {
      name    = "helm"
      primary = false
      cpus    = 8
      memory  = 16284
      role    = "Worker"
      job     = "Heavy"
      ceph    = "172.18.20.6"
      ip      = "10.1.10.66"
    }
    gond = {
      name    = "gond"
      primary = false
      cpus    = 4
      memory  = 8192
      role    = "Worker"
      job     = "Light"
      ceph    = "172.18.20.7"
      ip      = "10.1.10.67"
    }
  }
}