variable "proxmox_api_url" {
  type = string
}
variable "proxmox_user" {
  type = string
}
variable "proxmox_pass" {
  type = string
  sensitive = true
}
variable "iso_checksum" {
  type = string
}
variable "storage_pool" {
  type = string
}
variable "proxmox_node" {
  type = string
}
variable "template_name" {
  type = string
}
variable "iso_path" {
  type = string
}