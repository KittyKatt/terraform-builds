locals {
  node_type = var.manager ? "manager" : "worker"
}

data "template_file" "cloud" {
  template = "${templatefile("${path.module}/cloud-config-${local.node_type}.tmpl", 
    {
        name = var.name,
        mounts = var.mount_config,
        smbuser = var.smbuser,
        smbpass = var.smbpass,
        ssh_id = var.ssh_ids,
        ssh_key = var.ssh_keys
      }
    )}"
}

resource "local_file" "moradin-cloud" {
  content  = replace(replace(data.template_file.cloud.rendered, "/((?:^|\n)[\\s-]*)\"([\\w-]+)\":/", "$1$2:"), "- -", "  -")
  filename = "${path.module}/templates/${var.name}-config.yml"
}