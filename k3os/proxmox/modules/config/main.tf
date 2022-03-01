resource "local_file" "cloud_init" {
  content = var.content
  filename = "${path.root}/templates/${var.name}-config.yaml"
}

resource "null_resource" "cloud_init_config_files" {
  depends_on = [local_file.cloud_init]
  connection {
    type     = "ssh"
    user     = var.pve_user
    password = var.pve_password
    host     = var.target_host
  }

  provisioner "file" {
    source      = "${path.root}/templates/${var.name}-config.yaml"
    destination = "/mnt/pve/ISO/snippets/${var.name}-config.yaml"
  }
}