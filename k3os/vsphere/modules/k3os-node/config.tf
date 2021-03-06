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
  type    = list(string)
  default = []

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

locals {
  node_type = var.control_plane ? "server" : "agent"
  user_data = {
    hostname            = var.name
    # ssh_authorized_keys = [for user in var.ssh_access_github_users : "github:${user}"]

    write_files = [ var.k3os_write_files ]

    k3os = {
      server_url = var.k3s_server_url
      token      = var.k3s_token
      password   = "$1$dJlP8PEb$/GwHuWpU0ErTeAdQ5v/0k1"
      k3s_args = concat(
        [local.node_type, "--node-name=${var.name}"],
        var.k3s_args
      )

      #labels = var.k3s_node_labels
    }
  }
  user_data_yaml = replace(replace(yamlencode(local.user_data), "/((?:^|\n)[\\s-]*)\"([\\w-]+)\":/", "$1$2:"), "- -", "  -")
  #user_data_json = jsonencode(local.user_data)
}