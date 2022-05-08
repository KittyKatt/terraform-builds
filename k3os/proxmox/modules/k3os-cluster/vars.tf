variable "pve_user" {
  type = string
  sensitive = true
}
variable "pve_password" {
  type = string
  sensitive = true
}
variable "proxmox_hosts" {
  type    = list
  default = []
}
variable "proxmox_template" {
  type = string
}
variable "kubeapi_lb_ip" {
  type = string
}
variable "node_configs" {
  type = list(
    object({
      name          = string
      macaddr       = list(string)
      ipaddr        = string
      cpu_n         = string
      mem_n         = string
      control_plane = optional(bool)
      primary       = optional(bool)
    })
  )
}