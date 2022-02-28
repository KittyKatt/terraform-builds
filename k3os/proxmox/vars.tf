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
  sensitive = true
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

variable "ip_range_lower_boundary" {
  type = string
}
variable "ip_range_upper_boundary" {
  type = string
}

variable "domain_name" {
  type = string
}
variable "acme_email" {
  type = string
  sensitive = true
}
variable "api_token" {
  type = string
  sensitive = true
}