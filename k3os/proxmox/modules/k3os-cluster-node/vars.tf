variable "control_plane" {
  type        = bool
  description = "Whether this is a server and not just an agent node"
  default     = false
}
variable "k3s_server_url" {
  type        = string
  description = "URL of the primary node - fine to be empty on manager nodes"
}
variable "k3s_token" {
  type        = string
  description = "Token for joining the cluster"
  sensitive   = true
}
variable "k3s_args" {
  type        = list(string)
  default     = []
  description = "Additional arguments for the k3s process. See https://github.com/rancher/k3os#k3osk3s_args"
}
variable "k3os_write_files" {
  type = list(object({
    path        = string
    content     = string
    owner       = optional(string)
    permissions = optional(string)
    encoding    = optional(string)
    append      = optional(string)
  }))
  default = []
}
variable "pve_user" {
  type = string
}
variable "pve_password" {
  type = string
}
variable "proxmox_template" {
  type = string
}
variable "proxmox_hosts" {
  type    = list
  default = []
}
variable "name" {
  type = string
}
variable "mem_n" {
  type = string
}
variable "cpu_n" {
  type = string
}
variable "macaddr" {
  type    = list(string)
  default = []
}