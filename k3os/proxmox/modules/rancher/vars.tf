variable "rancher_created" {
  type = bool
}

variable "rancher_bootstrap_password" {
  type = string
  sensitive = true
}