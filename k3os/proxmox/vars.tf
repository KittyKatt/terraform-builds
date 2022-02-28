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
variable "pm_url" {
  type = string
}
variable "proxmox_hosts" {
  type    = list
  default = []
}
variable "pm_user" {
  type = string
  sensitive = true
}
variable "pm_password" {
  type = string
  sensitive = true
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
variable "primary_node_name" {
  type = string
}
variable "node_names" {
  type = set(string)
}
