locals {
  node_type = var.manager ? "manager" : "worker"
}

data "template_file" "cloud" {
  template = "${templatefile("${path.module}/cloud-config-${local.node_type}.tmpl", 
  {
    name      = var.name,
    mounts    = var.mount_config,
    network   = var.network_config,
    smbuser   = var.smbuser,
    smbpass   = var.smbpass,
    smbdomain = var.smbdomain,
    ssh_id    = var.ssh_ids,
    ssh_key   = var.ssh_keys
  })}"
}

resource "local_file" "cloud-file" {
  content  = replace(replace(data.template_file.cloud.rendered, "/((?:^|\n)[\\s-]*)\"([\\w-]+)\":/", "$1$2:"), "- -", "  -")
  filename = "${path.root}/templates/${var.name}-config.yml"
}
resource "local_file" "meta-file" {
  content  = "instance-id: ${var.name}"
  filename = "${path.root}/templates/${var.name}-meta.yml"
}

resource "null_resource" "cloud-file-upload" {
  depends_on = [
    local_file.cloud-file,
    local_file.meta-file
  ]
  connection {
    type     = "ssh"
    user     = var.pve_user
    password = var.pve_password
    host     = var.pve_host
  }

  provisioner "file" {
    source      = "${path.root}/templates/${var.name}-config.yml"
    destination = "/mnt/pve/ISO/snippets/${var.name}-config.yml"
  }
  provisioner "file" {
    source      = "${path.root}/templates/${var.name}-meta.yml"
    destination = "/mnt/pve/ISO/snippets/${var.name}-meta.yml"
  }
}