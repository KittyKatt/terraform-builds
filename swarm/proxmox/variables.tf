variable "smbusername" {
  type = string
  sensitive = true
}
variable "smbpassword" {
  type = string
  sensitive = true
}

locals {
  primary_node_name = "tyr"
  node_names = toset([ 
    "oghma",
    "grumbar",
    "helm",
    "tymora",
    "deneir"
  ])
}