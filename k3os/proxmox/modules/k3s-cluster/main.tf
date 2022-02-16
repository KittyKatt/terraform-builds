locals {
  qemu_guest_agent = {
    path    = "/etc/conf.d/qemu-guest-agent"
    content = "GA_PATH=\"/dev/vport1p1\""
  }
  node_names = toset([
    "dumathoin",
    "abbathor"
  ])
  gateway     = "10.1.10.1"
  netmask     = "255.255.255.0"
  nameservers = "10.1.10.58,10.1.10.1"
}