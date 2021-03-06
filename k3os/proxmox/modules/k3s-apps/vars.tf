variable "domain_name" {
  type = string
}
variable "acme_email" {
  type = string
}
variable "api_token" {
  type = string
}
variable "kubeapi_lb_ip" {
  type = string
}
variable "ipa_dnssec_key" {
  type = string
  sensitive = true
}
variable "ipa_fqdn" {
  type = string
  sensitive = true
}

variable "k3s_cluster_created" {
  type = bool
}

variable "ip_range_lower_boundary" {
  type = string
}
variable "ip_range_upper_boundary" {
  type = string
}