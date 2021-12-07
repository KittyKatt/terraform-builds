terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.3"
    }
  }
  backend "http" {
  }
}

provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url      = var.pm_url
  pm_user         = var.pm_user
  pm_password     = var.pm_password
}