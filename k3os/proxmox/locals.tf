locals {
  environments = {
    # Terraform Default Workspace
    default = {
      domain_name = "kittykatt.co"
      proxmox_hosts = [
        "toril"
      ]
      proxmox_template = "k3os-10032022"
      node_configs = [
        {
          name          = "moradin"
          macaddr       = [ "ce:59:af:c2:b1:f4" ]
          ipaddr        = "10.1.10.41"
          cpu_n         = "2"
          mem_n         = "8192"
          control_plane = true
          primary       = true
        },
        {
          name          = "mya"
          macaddr       = [ "de:0c:63:e9:df:bb" ]
          ipaddr        = "10.1.10.42"
          cpu_n         = "2"
          mem_n         = "8192"
          control_plane = true
        },
        {
          name          = "thautam"
          macaddr       = [ "90:24:52:8f:68:b7" ]
          ipaddr        = "10.1.10.43"
          cpu_n         = "2"
          mem_n         = "8192"
          control_plane = true
        },
        {
          name          = "vergadain"
          macaddr       = [ "8a:2f:85:d3:24:44" ]
          ipaddr        = "10.1.10.74"
          cpu_n         = "2"
          mem_n         = "8192"
        },
        {
          name          = "dumathoin"
          macaddr       = [ "d4:a2:48:15:4a:8a" ]
          ipaddr        = "10.1.10.75"
          cpu_n         = "2"
          mem_n         = "8192"
        },
        {
          name          = "abbathor"
          macaddr       = [ "2a:3e:96:eb:64:29" ]
          ipaddr        = "10.1.10.76"
          cpu_n         = "2"
          mem_n         = "4096"
        },
        {
          name          = "hanseath"
          macaddr       = [ "0c:d1:be:07:93:50" ]
          ipaddr        = "10.1.10.77"
          cpu_n         = "2"
          mem_n         = "4096"
        },
      ]
      kubeapi_lb_ip           = "10.1.10.40"
      ip_range_lower_boundary = "10.32.100.11"
      ip_range_upper_boundary = "10.32.100.19"
    },
    # Terraform Workspace: "dev"
    dev = {
      domain_name = "kittykatt.co"
      proxmox_hosts = [
        "toril"
      ]
      node_configs = [
        {
          name          = "k3s-dev1"
          macaddr       = [ "9e:fd:19:d3:15:8f" ]
          cpu_n         = "2"
          mem_n         = "4096"
          control_plane = true
          primary       = true
        },
        {
          name          = "k3s-dev2"
          macaddr       = [ "d6:d7:a1:19:6c:4f" ]
          cpu_n         = "2"
          mem_n         = "4096"
          control_plane = false
        },
        {
          name          = "k3s-dev3"
          macaddr       = [ "b6:57:fa:a1:48:55" ]
          cpu_n         = "2"
          mem_n         = "4096"
          control_plane = false
        }
      ]
      kubeapi_lb_ip           = "10.1.10.80"
      ip_range_lower_boundary = "10.32.100.21"
      ip_range_upper_boundary = "10.32.100.25"
    }
  }
}

locals {
  config = "${lookup(local.environments, terraform.workspace, local.environments["default"])}"
}
