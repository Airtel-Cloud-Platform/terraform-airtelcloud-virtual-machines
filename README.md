# VM Module

Terraform module for provisioning Virtual Machines on Airtel Cloud.

## Features

* Creates Airtel Cloud VM instances
* Supports Linux and Windows operating systems
* Supports custom images and flavors
* Configurable boot disk size
* Supports resource tagging
* Exposes VM networking information through outputs

## Usage

### Basic Example

```hcl
module "vm" {
  source = "..."

  vm_name = "web01"

  os_type = "linux"

  flavor = "ccd.Large"
  image  = "CentOS_Stream9_May2026"

  vpc_id    = "vpc-id"
  subnet_id = "subnet-id"

  availability_zone = "S1"
}
```

### Complete Example

```hcl
module "vm" {
  source = "../../"

  vm_name = "production-web01"

  os_type = "linux"

  flavor = "ccd.Large"
  image  = "CentOS_Stream9_Mar2026"

  vpc_id    = "vpc-id"
  subnet_id = "subnet-id"

  security_group_id = "sg-id"

  availability_zone = "S2"

  boot_from_volume = true
  disk_size        = 100

  keypair_id = "keypair-id"

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello World"
  EOF

  enable_backup  = true
  protection_plan = "daily"

  start_date = "2026-06-01"
  start_time = "02:00"

  vm_count = 1

  description = "Production web server"

  tags = {
    Environment = "production"
    Application = "web"
    Owner       = "platform-team"
  }
}
```
## Creating Multiple VMs

Use Terraform `for_each` to create multiple VM instances.

```hcl
locals {
  vms = {
    web01 = {}
    web02 = {}
    web03 = {}
  }
}

module "vm" {
  for_each = local.vms

  source = "Airtel-Cloud-Platform/vm/airtelcloud"

  vm_name = each.key

  os_type = "linux"

  flavor = "ccd.Large"
  image  = "CentOS_Stream9_May2026"

  vpc_id    = var.vpc_id
  subnet_id = var.subnet_id

  availability_zone = "S1"
}
```
## Inputs

| Name | Description | Type | Required | Default |
|------|-------------|------|----------|---------|
| vm_name | Virtual machine name | string | Yes | - |
| os_type | Operating system type (linux/windows) | string | Yes | - |
| flavor | VM flavor | string | Yes | - |
| image | VM image | string | Yes | - |
| vpc_id | Target VPC ID | string | Yes | - |
| subnet_id | Target subnet ID | string | Yes | - |
| availability_zone | Availability zone | string | Yes | - |
| boot_from_volume | Whether VM should boot from volume | bool | No | true |
| disk_size | Boot disk size in GB | number | No | 100 |
| security_group_id | Security Group ID to attach to VM | string | No | null |
| keypair_id | Keypair ID for SSH access | string | No | null |
| user_data | Cloud-init or bootstrap script | string | No | null |
| volume_type_id | Volume type ID | string | No | null |
| enable_backup | Enable VM backup | bool | No | false |
| protection_plan | Backup protection plan | string | No | null |
| start_date | Backup start date (YYYY-MM-DD) | string | No | null |
| start_time | Backup start time (HH:MM) | string | No | null |
| description | VM description | string | No | "" |
| tags | Resource tags | map(string) | No | {} |

## Outputs

## Outputs

| Name | Description |
|------|-------------|
| vm_id | VM ID |
| vm_name | VM name |
| vm_status | Current VM status |
| private_ip | VM private IP address |
| public_ip | VM public IP address |
| vm | Complete VM output object |

## Requirements

| Name                  | Version  |
| --------------------- | -------- |
| Terraform             | >= 1.5   |
| Airtel Cloud Provider | >= 1.0.4 |

