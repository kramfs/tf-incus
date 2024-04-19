##############
## MINIKUBE ##
##############
# Description: Provision a local minikube cluster for that can be used for local development

## TERRAFORM DEFINITION ##
terraform {
  required_providers {
    incus = {
      source  = "lxc/incus"
      version = "~>0.1" # Good practice to pin to a specific provider version
    }
  }
}

## PROVIDER ##
provider "incus" {
  # If you're running terraform from a system where Incus is not installed
  # then you can define all the remotes below:
  generate_client_certificates = true
  accept_remote_certificate    = true

  #remote {
  #  name     = "inclus-cluster"
  #  scheme   = "https"
  #  address  = "127.0.0.1"
  #  token    = "token"
  #  default  = true
  #  port = 8443
  #}
}