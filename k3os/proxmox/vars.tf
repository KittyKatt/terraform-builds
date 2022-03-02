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
variable "pm_user" {
  type = string
  sensitive = true
}
variable "pm_password" {
  type = string
  sensitive = true
}
variable "acme_email" {
  type = string
  sensitive = true
}
variable "api_token" {
  type = string
  sensitive = true
}
variable "rancher_bootstrap_password" {
  type = string
  sensitive = true
}