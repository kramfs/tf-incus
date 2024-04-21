# Description

Quickly bring up a system container or virtual machine for easy testing with Incus and LXC.

[Incus](https://linuxcontainers.org/incus/introduction/) is a `container` and `virtual machine` manager.

It allows you to run multiple `isolated` Linux containers or virtual machines on a single host machine, providing a lightweight and efficient way to virtualize an infrastructure.

Based on [LXC](https://linuxcontainers.org/lxc/introduction/) for containers and QEMU for virtual machines, it offers a seamless cloud-like experience scaling from a developer's laptop to a full cluster.

LXC containers are often considered as something in the middle between a chroot and a full fledged virtual machine. The goal of LXC is to create an environment as close as possible to a standard Linux installation but without the need for a separate kernel.

With that, it is often used and a perfect choice for system containers. See the difference here between `Application` and `System` containers:

- https://www.virtuozzo.com/application-platform-docs/what-are-system-containers/
- https://www.sumologic.com/blog/application-containers-vs-system-containers-understanding-difference/

It's a popular choice among developers and sysadmins looking for a lightweight and flexible way to test and deploy isolated and/or specialized applications.

## Pre-requisites

- Terraform
    - HashiCorp distributes Terraform as a [binary package](https://developer.hashicorp.com/terraform/install). You can also install Terraform using popular package managers.
- Incus
    - The easiest way to install Incus is to [install one of the available packages](https://linuxcontainers.org/incus/docs/main/installing/#installing-from-package), but you can also install Incus from the [sources](https://linuxcontainers.org/incus/docs/main/installing/#installing-from-source).
- LXC
    - Follow the [installation](https://linuxcontainers.org/lxc/getting-started/) instruction.
    - In most cases, you'll find recent versions of LXC available for your Linux distribution. Either directly in the distribution's package repository or through some backport channel.


## Available Tasks
Typing `task` will show up the available options

```
❯ task
task: [default] task --list-all
task: Available tasks for this project:
* bash:          Shell (bash) into the instance
* cleanup:       Destroy and clean up the instance
* console:       Connect to the instance console
* default:       Show this task list
* up:            Bring up the cluster
```

## Task UP!
To bring up a VM/Instance:

```
task up
```

Example:

```
❯ task up
task: [init] terraform init -upgrade

Initializing the backend...

Initializing provider plugins...
- Finding lxc/incus versions matching "~> 0.1"...
- Installing lxc/incus v0.1.1...
- Installed lxc/incus v0.1.1 (self-signed, key ID C638974D64792D67)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
task: [apply] terraform apply $TF_AUTO

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # incus_instance.tf-incus-vm-iso[0] will be created
  + resource "incus_instance" "tf-incus-vm-iso" {
      + config           = {
          + "boot.autostart"        = "false"
          + "user.access_interface" = "eth0"
        }
      + ephemeral        = false
      + image            = "images:ubuntu/noble/desktop"
      + ipv4_address     = (known after apply)
      + ipv6_address     = (known after apply)
      + limits           = {
          + "cpu"    = "2"
          + "memory" = "8GiB"
        }
      + mac_address      = (known after apply)
      + name             = "tf-incus-vm-iso"
      + profiles         = [
          + "tf-profile",
        ]
      + running          = true
      + status           = (known after apply)
      + target           = (known after apply)
      + type             = "virtual-machine"
      + wait_for_network = true
        # (1 unchanged attribute hidden)

      + device {
          + name       = "iso-installer"
          + properties = {
              + "boot.priority" = "1"
              + "pool"          = "incus"
              + "source"        = "fedora-40-iso"
            }
          + type       = "disk"
        }
    }

  # incus_network.tf-network[0] will be created
  + resource "incus_network" "tf-network" {
      + config      = {
          + "ipv4.address" = "10.29.217.1/24"
          + "ipv4.nat"     = "true"
        }
      + managed     = (known after apply)
      + name        = "tf-network"
      + type        = (known after apply)
        # (1 unchanged attribute hidden)
    }

  # incus_profile.tf-profile[0] will be created
  + resource "incus_profile" "tf-profile" {
      + config      = {
          + "security.secureboot" = "false"
        }
      + name        = "tf-profile"
        # (1 unchanged attribute hidden)

      + device {
          + name       = "eth0"
          + properties = {
              + "nictype" = "bridged"
              + "parent"  = "incusbr0"
            }
          + type       = "nic"
        }
      + device {
          + name       = "root"
          + properties = {
              + "path" = "/"
              + "pool" = "incus"
              + "size" = "30GiB"
            }
          + type       = "disk"
        }
    }

Plan: 3 to add, 0 to change, 0 to destroy.
incus_network.tf-network[0]: Creating...
incus_profile.tf-profile[0]: Creating...
incus_profile.tf-profile[0]: Creation complete after 0s [name=tf-profile]
incus_instance.tf-incus-vm-iso[0]: Creating...
incus_network.tf-network[0]: Creation complete after 0s [name=tf-network]
incus_instance.tf-incus-vm-iso[0]: Still creating... [10s elapsed]
incus_instance.tf-incus-vm-iso[0]: Still creating... [20s elapsed]
incus_instance.tf-incus-vm-iso[0]: Creation complete after 23s [name=tf-incus-vm-iso]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
task: [up] printf "Now check the vm console with \n incus console tf-incus-vm-iso --type vga"
Now check the vm console with
 incus console tf-incus-vm-iso --type vga
```

## Task Bash

To Shell (bash) into the instance:

```
task bash
```

```
❯ task bash
task: [bash] incus exec tf-incus-vm bash

root@tf-incus-vm:~#
```

## Task Console

To connect to the instance console:

```
task console
```

```
❯ task console
task: [console] incus console tf-incus-vm --type vga
```


## Task Cleanup!
To destroy and clean up the instance/vm:
```
task cleanup
```

Example:
```
❯ task cleanup
task: [destroy] terraform destroy $TF_AUTO
incus_network.tf-network[0]: Refreshing state... [name=tf-network]
incus_profile.tf-profile[0]: Refreshing state... [name=tf-profile]
incus_instance.tf-incus-vm[0]: Refreshing state... [name=tf-incus-vm]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # incus_instance.tf-incus-vm[0] will be destroyed
  - resource "incus_instance" "tf-incus-vm" {
      - config           = {
          - "boot.autostart"        = "false"
          - "user.access_interface" = "eth0"
        } -> null
      - ephemeral        = false -> null
      - image            = "images:ubuntu/noble/desktop" -> null
      - ipv4_address     = "10.29.216.213" -> null
      - ipv6_address     = "fd42:1a50:fb1f:f082:216:3eff:fe50:7698" -> null
      - limits           = {
          - "cpu"    = "2"
          - "memory" = "8GiB"
        } -> null
      - mac_address      = "00:16:3e:50:76:98" -> null
      - name             = "tf-incus-vm" -> null
      - profiles         = [
          - "tf-profile",
        ] -> null
      - running          = true -> null
      - status           = "Running" -> null
      - type             = "virtual-machine" -> null
      - wait_for_network = true -> null
        # (2 unchanged attributes hidden)

      - device {
          - name       = "iso-installer" -> null
          - properties = {
              - "boot.priority" = "1"
              - "pool"          = "incus"
              - "source"        = "fedora-40-iso"
            } -> null
          - type       = "disk" -> null
        }
    }

  # incus_network.tf-network[0] will be destroyed
  - resource "incus_network" "tf-network" {
      - config      = {
          - "ipv4.address" = "10.29.217.1/24"
          - "ipv4.nat"     = "true"
        } -> null
      - managed     = true -> null
      - name        = "tf-network" -> null
      - type        = "bridge" -> null
        # (1 unchanged attribute hidden)
    }

  # incus_profile.tf-profile[0] will be destroyed
  - resource "incus_profile" "tf-profile" {
      - config      = {
          - "security.secureboot" = "false"
        } -> null
      - name        = "tf-profile" -> null
        # (1 unchanged attribute hidden)

      - device {
          - name       = "eth0" -> null
          - properties = {
              - "nictype" = "bridged"
              - "parent"  = "incusbr0"
            } -> null
          - type       = "nic" -> null
        }
      - device {
          - name       = "root" -> null
          - properties = {
              - "path" = "/"
              - "pool" = "incus"
              - "size" = "30GiB"
            } -> null
          - type       = "disk" -> null
        }
    }

Plan: 0 to add, 0 to change, 3 to destroy.
incus_network.tf-network[0]: Destroying... [name=tf-network]
incus_instance.tf-incus-vm[0]: Destroying... [name=tf-incus-vm]
incus_network.tf-network[0]: Destruction complete after 1s
incus_instance.tf-incus-vm[0]: Destruction complete after 3s
incus_profile.tf-profile[0]: Destroying... [name=tf-profile]
incus_profile.tf-profile[0]: Destruction complete after 0s

Destroy complete! Resources: 3 destroyed.
task: [cleanup] find . -name '*terraform*' -print | xargs rm -Rf
```