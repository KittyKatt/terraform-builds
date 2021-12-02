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
variable "vm_job" {
  type    = string
  default = null
}


locals {
  ssh_key = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGgqObb0JP40+JWKMZbujkcNeiacPxgWZ9/YOmrit0I2f79umIoYy5HaSUts6Q7LZx+AhjhRRWcC3Za/pc2eovYH6PErGQ/Q6P3CIM2ndgTGJHMyK0Nym6GzfN8u99uFIStqK2uTkdnzTnrZCdVUQP0UVutWX5pdGSeyS3KVo5IEuUl44Dtwu4vpe1vgELU5O/VAv0q6aSJ1RzrhuZJhWHDAdpumnKEhRRlVeU+LboVC7bfrDmfE9dhZrD26QuqVy2LUXx+KiLw8Qo8+bXW5GpzTmIHgMDQxIXqRthAY2gifnzPqowa0H1VFU4GVKnJq9WEqO8qTIOuYxxqUgjsh3Hi8JBQ47YaiAQp9wKvQ2caqtRZg5IWQ+MBPlC7Nm1W9aBABSqXd8EvRp9VvnzcuUhWUbRk4mmm7tC+jH2OWGmrQwiyKLJVdjLbqUbGB2FMvrKsEzMIw619m4vwUmMBv6/xicAcedU7bss345JcdzNS+VrdAvwX64+5jMSfxmN+cM= katie@mielikki"
  ]
  ssh_id  = []
  # Network configuration
  network = {
    "config"      = "static"
    "gateway"     = "10.1.10.1"
    "subnet"      = "24"
    "nameservers" = ["10.1.10.59", "10.1.10.1"]
    "address"     = var.vm_ip_addr
    "domain"      = "kittykatt.co"
  }
  # Mount configurations for cloud-config
  mounts = [
    {
      source      = "//10.1.10.46/Infrastructure"
      destination = "/shares/Infrastructure"
      type        = "cifs"
      options     = "credentials=/root/smb-creds,uid=1083,gid=1082,vers=3.0,mfsymlinks"
    },
    {
      source      = "10.1.10.46:/export/DockerVol"
      destination = "/shares/Docker"
      type        = "nfs4"
      options     = "rw,sync,vers=4.2,relatime,hard,proto=tcp"
    },
    {
      source      = "//10.1.10.46/Media"
      destination = "/shares/Media"
      type        = "cifs"
      options     = "credentials=/root/smb-creds,uid=1083,gid=1082,vers=3.0,mfsymlinks"
    }
  ]
}