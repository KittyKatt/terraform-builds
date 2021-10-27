

module "cluster" {
  source            = "./modules/cluster"

  primary_node_name = local.primary_node_name
  node_names        = local.node_names
  smbusername       = var.smbusername
  smbpassword       = var.smbpassword
}