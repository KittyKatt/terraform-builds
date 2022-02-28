terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.8.0"
    }
    remote = {
      source = "tenstad/remote"
      version = "0.0.23"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.13.1"
    }
  }
}

