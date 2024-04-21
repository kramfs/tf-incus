## Standard VM ##
# See available images: "incus image list images:ubuntu/24"
# Desktops images:
#   images:ubuntu/noble/desktop
#   images:archlinux/desktop-gnome

resource "incus_instance" "tf-incus-vm" {
  count    = var.instance.install ? 1 : 0
  name     = "tf-incus-vm"
  image    = "images:ubuntu/noble/desktop" # When booting from an ISO, this is NOT used and just a place holder since it's a require param in the provider
  type     = "virtual-machine"     # Option: container, virtual-machine. Defaults: container
  profiles = ["${incus_profile.tf-profile[0].name}"]
  running  = true

  ## REF: https://linuxcontainers.org/incus/docs/main/reference/instance_options/
  config = {
    "boot.autostart"        = false
    "user.access_interface" = "eth0"
  }

  # DATA VOLUME
  #device {
  #  name = "data"
  #  type = "disk"
  #  properties = {
  #    pool = "incus"
  #    size = "30GiB"
  #    path = "/media"
  #  }
  #}

  # This is used to attach an ISO installer
  device {
    name = "iso-installer"
    type = "disk"

    properties = {
      pool            = "incus"
      source          = "fedora-40-iso" ## Which ISO to use. Values: fedora-40-iso, ubuntu-lts-24-04-iso
      "boot.priority" = 1               # Option: 10. Higher value boots this device first. Set the value to 1 will fall back to using the image "incus_instance.tf-incus-vm-iso.image" as defined above
    }
  }

  ## REF: https://linuxcontainers.org/incus/docs/main/reference/instance_options/#instance-resource-limits
  limits = {
    cpu    = 2
    memory = "8GiB" # Percentage of the host’s memory or a fixed value in bytes. Various suffixes are supported.
    #memory.enforce = "hard" # Default: hard. Whether the memory limit is hard or soft
  }
}