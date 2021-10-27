

terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.8.0"
    }
  }
}

variable "macaddr" {
  type = string
}
variable "ip" {
  type = string
}