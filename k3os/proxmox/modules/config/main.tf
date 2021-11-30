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
variable "pve_host" {
  type = string
  sensitive = true
}

resource "local_file" "cloud_init" {
  content = var.content
  filename = "../../templates/${var.name}-config.yaml"
}

resource "null_resource" "cloud_init_config_files" {
  depends_on = [local_file.cloud_init]
  connection {
    type     = "ssh"
    user     = var.pve_user
    password = var.pve_password
    host     = var.pve_host
  }

  provisioner "file" {
    source      = "../../templates/${var.name}-config.yaml"
    destination = "/mnt/pve/ISO/snippets/${var.name}-config.yaml"
  }
}