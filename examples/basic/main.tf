terraform {
  required_providers {
    airtelcloud = {
      source  = "Airtel-Cloud-Platform/airtelcloud"
      version = ">= 1.1.3"
    }
  }
}

provider "airtelcloud" {

  api_endpoint = "https://south.cloud.airtel.in"

  api_key    = var.airtel_api_key
  api_secret = var.airtel_api_secret

  region       = "south"
  organization = var.organization
  project_name = var.project_name
}

module "vm" {

  source = "../../"

  vm_name = "web01"

  os_type = "linux"

  flavor = "ccd.Large"

  image = "CentOS_Stream9_May2026"

  vpc_name = "production"

  subnet_name = "private"

  availability_zone = "S1"

  keypair_name = "platform-key"

}
