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
variable "node_configs" {
  type = list(
    object({
      name    = string
      macaddr = list(string)
      cpu_n   = string
      mem_n   = string
      primary = optional(bool)
    })
  )
}