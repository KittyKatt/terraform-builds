# Input variables from environment variables
variable "smbusername" {
  type = string
  sensitive = true
}
variable "smbpassword" {
  type = string
  sensitive = true
}

variable "name" {
  type = string
  default = null
}
variable "manager" {
  type = bool
  default = false
}

locals {
  ssh_key = []
  ssh_id = [
    "gh:KittyKatt"
  ]
  # Network configuration
  network = {
    "config"      = "static"
    "gateway"     = "10.1.10.1"
    "subnet"      = "24"
    "nameservers" = ["10.1.10.58", "10.1.10.1"]
    "domain"      = "kittykatt.co"
  }
  # Mount configurations for cloud-config
  mounts = [
    {
      source      = "//10.1.10.46/Infrastructure"
      destination = "/shares/Infrastructure"
      options     = "credentials=/root/smb-creds,uid=1083,gid=1082,vers=3.0,mfsymlinks"
    },
    {
      source      = "//10.1.10.46/Docker"
      destination = "/shares/Docker"
      options     = "credentials=/root/smb-creds,uid=1083,gid=1082,vers=3.0,mfsymlinks"
    },
    {
      source      = "//10.1.10.46/Media"
      destination = "/shares/Media"
      options     = "credentials=/root/smb-creds,uid=1083,gid=1082,vers=3.0,mfsymlinks"
    }
  ]
}