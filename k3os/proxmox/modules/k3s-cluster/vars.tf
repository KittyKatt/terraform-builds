variable "pve_user" {
  type = string
}
variable "pve_password" {
  type = string
}
variable "proxmox_hosts" {
  type    = list
  default = []
}

variable "primary_node_name" {
  type = string
}
variable "node_names" {
  type = set(string)
}
variable "node_configs" {
  type = map(
    object({
      name    = string
      macaddr = list(string)
      cpu_n   = string
      mem_n   = string
    })
  )
}