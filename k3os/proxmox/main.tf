terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.8.0"
    }
  }
}

variable "pve_user" {
  type = string
  sensitive = true
}
variable "pve_password" {
  type = string
  sensitive = true
}
variable "pve_host" {
  type = string
  sensitive = true
}

variable "pm_user" {
  type = string
  sensitive = true
}
variable "pm_password" {
  type = string
  sensitive = true
}

provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url = "https://toril.kittykatt.co:8006/api2/json"
  pm_user = var.pm_user
  pm_password = var.pm_password
}

module "cluster" {
  source = "./modules/k3s-cluster"

  pve_user        = var.pve_user
  pve_password    = var.pve_password
  pve_host        = var.pve_host
}

output "k8s_api_token" {
  value     = module.cluster.k8s_api_token
  sensitive = true
}
output "control_plane_url" {
  value     = module.cluster.control_plane_url
}