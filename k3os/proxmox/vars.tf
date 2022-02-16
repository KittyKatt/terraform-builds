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