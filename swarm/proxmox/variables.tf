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
  })
  default = {
    config      = null
    gateway     = null
    subnet      = null
    nameservers = null
    domain      = null
  }
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
  primary_node_name = "tyr2"
  node_names        = toset([ 
    "oghma2",
    "grumbar2",
    "helm2",
    "tymora2",
    "deneir2"
  ])
  configuration = {
    tyr2 = {
      name   = "tyr2"
      cpus   = 2,
      memory = 4096,
      job    = "Manager",
      ip     = "10.1.10.61"
    },
    oghma2 = {
      name   = "oghma2"
      cpus   = 4,
      memory = 8192,
      job    = "Database",
      ip     = "10.1.10.62"
    },
    grumbar2 = {
      name   = "grumbar2"
      cpus   = 4,
      memory = 8192,
      job    = "Web",
      ip     = "10.1.10.63"
    },
    tymora2 = {
      name   = "tymora2"
      cpus   = 4,
      memory = 4096,
      job    = "Mail",
      ip     = "10.1.10.64"
    },
    deneir2 = {
      name   = "deneir2"
      cpus   = 8,
      memory = 8192,
      job    = "Media",
      ip     = "10.1.10.65"
    },
    helm2 = {
      name   = "helm2"
      cpus   = 2,
      memory = 4096,
      job    = "Source",
      ip     = "10.1.10.66"
    }
  }
}