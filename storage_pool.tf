## POOL ##
/*
resource "incus_storage_pool" "tf-pool" {
  count = var.storage_pool.install ? 1 : 0
  name   = "tf-pool"
  driver = "dir"
  config = {
    source = "$HOME/data/tf-pool"
  }
}
*/

/*
resource "incus_storage_pool" "incus" {
  name    = "incus"
  #project = "default"
  driver  = "dir"
}

import {
  to = incus_storage_pool.incus
  id = "proj/default"
}
*/