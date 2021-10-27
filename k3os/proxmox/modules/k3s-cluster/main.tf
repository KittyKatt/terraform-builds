locals {
  qemu_guest_agent = {
    path    = "/etc/conf.d/qemu-guest-agent"
    content = "# Blank File"
  }
}