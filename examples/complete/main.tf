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

  vm_name = "production-web01"

  os_type = "linux"

  flavor = "ccd.XLarge"

  image = "CentOS_Stream9_May2026"

  vpc_name = "production"

  subnet_name = "private"

  security_group_name = "default"

  keypair_name = "platform-key"

  availability_zone = "S1"

  description = "Production Application Server"

  boot_from_volume = true

  disk_size = 150

  volume_type_id = "1"

  user_data = <<-EOF
#!/bin/bash
hostnamectl set-hostname production-web01
echo "Provisioned by Terraform" >/etc/motd
EOF

  enable_backup = true

  protection_plan = "daily"

  start_date = "2026-06-01"

  start_time = "02:00"

  tags = {
    Environment = "Production"
    Application = "Web"
    Team        = "Platform"
    ManagedBy   = "Terraform"
  }

  timeouts = {
    create = "30m"
    delete = "20m"
  }

}
