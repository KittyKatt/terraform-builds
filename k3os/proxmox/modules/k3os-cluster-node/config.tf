locals {
  node_type = var.control_plane ? "server" : "agent"
  user_data = {
    hostname            = var.name
    # ssh_authorized_keys = [for user in var.ssh_access_github_users : "github:${user}"]

    write_files = [ var.k3os_write_files ]

    k3os = {
      server_url = var.k3s_server_url
      token      = var.k3s_token
      k3s_args = concat(
        [local.node_type, "--node-name=${var.name}"],
        var.k3s_args
      )
    }
  }
  user_data_yaml = replace(replace(yamlencode(local.user_data), "/((?:^|\n)[\\s-]*)\"([\\w-]+)\":/", "$1$2:"), "- -", "  -")
}

module "user_data" {
  depends_on = [ random_shuffle.target_host ]
  source     = "../k3os-node-config"

  pve_user     = var.pve_user
  pve_password = var.pve_password

  name        = var.name
  content     = local.user_data_yaml
  target_host = random_shuffle.target_host.result[0]
}
