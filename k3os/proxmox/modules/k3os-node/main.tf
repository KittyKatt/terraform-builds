terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.8.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

resource "random_shuffle" "target_host" {
  input        = var.proxmox_hosts
  result_count = 1
}