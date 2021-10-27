module "cluster" {
  source            = "./modules/cluster"

  primary_node_name = local.primary_node_name
  node_names        = local.node_names
  smbusername       = var.smbusername
  smbpassword       = var.smbpassword
}

# module "cloud-config" {
#     source = "./modules/config"

#     name           = "moradin"
#     ip_address     = "10.1.10.41"
#     manager        = true
#     network_config = var.network
#     mount_config   = local.mounts
#     ssh_ids        = var.ssh_id
#     ssh_keys       = var.ssh_key
#     smbuser        = var.smbusername
#     smbpass        = var.smbpassword
# }