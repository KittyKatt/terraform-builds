resource "local_file" "ansible-inventory" {
  content = templatefile("${path.module}/inventory.tmpl",
    {
      node-configs   = var.node-configs
    }
  )
  filename        = "${path.module}/inventory.yml"
  file_permission = 664
}