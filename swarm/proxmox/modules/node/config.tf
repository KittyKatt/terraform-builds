module "configuration" {
    source = "../config"

    name           = var.name
    # ip_address     = var.ip_address
    manager        = var.manager ? true : false
    network_config = local.network
    mount_config   = local.mounts
    ssh_ids        = local.ssh_id
    ssh_keys       = local.ssh_key
    smbuser        = var.smbusername
    smbpass        = var.smbpassword
}