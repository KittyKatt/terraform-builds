variable "content" {
  type = string
}
variable "name" {
  type = string
}
variable "pve_user" {
  type = string
  sensitive = true
}
variable "pve_password" {
  type = string
  sensitive = true
}
variable "target_host" {
  type = string
}