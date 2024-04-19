resource "incus_instance" "tf-incus-vm" {
  count   = var.instance.install ? 1 : 0
  name     = "tf-incus-vm"
  image    = "images:ubuntu/23.10"
  type     = "virtual-machine" # Option: container, virtual-machine. Defaults: container
  profiles = ["${incus_profile.tf-profile[0].name}"]
  running = true

  ## REF: https://linuxcontainers.org/incus/docs/main/reference/instance_options/
  config = {
    "boot.autostart" = false
    "user.access_interface" = "eth0"
  }

  #device {
  #  name = "root"
  #  type = "disk"
  #  properties = {
  #    pool = "default"
  #    size = "30GiB"
  #    path = "/"
  #  }
  #}

  ## REF: https://linuxcontainers.org/incus/docs/main/reference/instance_options/#instance-resource-limits
  limits = {
    cpu    = 2
    memory = "8GiB" # Percentage of the host’s memory or a fixed value in bytes. Various suffixes are supported.
    #memory.enforce = "hard" # Default: hard. Whether the memory limit is hard or soft
  }
}