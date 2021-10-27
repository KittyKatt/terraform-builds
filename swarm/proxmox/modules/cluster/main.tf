module "primary" {
  source = "../node"

  manager = true
  name = var.primary_node_name
  smbpassword = var.smbpassword
  smbusername = var.smbusername
}

module "workers" {
  source = "../node"
  
  for_each = var.node_names

  name = each.key
  smbpassword = var.smbpassword
  smbusername = var.smbusername
}