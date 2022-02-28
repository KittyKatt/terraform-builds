locals {
  qemu_guest_agent = {
    path    = "/etc/conf.d/qemu-guest-agent"
    content = "GA_PATH=\"/dev/vport1p1\""
  }
}