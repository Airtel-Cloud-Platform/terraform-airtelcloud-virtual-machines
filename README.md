# Airtel Cloud Virtual Machine Terraform Module

This Terraform module provisions Virtual Machines (VMs) on Airtel Cloud using the `airtelcloud_vm` resource.

## Capabilities

- VM creation
- Boot from volume
- Flavor by ID or name
- Image by ID, name, or snapshot name
- VPC by ID or name
- Subnet by ID or name
- Security groups by ID list or name list
- SSH keypair authentication
- Linux admin username/password authentication
- Backup scheduling by date or weekday
- Labels
- Resource timeouts

---

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.3 |
| airtelcloud | >= 1.1.4 |

---

## Providers

| Name | Version |
|------|---------|
| airtelcloud | >= 1.1.4 |

---

## Usage

### Basic Example

```hcl
module "vm" {
  source = "Airtel-Cloud-Platform/virtual-machines/airtelcloud"

  vm_name = "web01"
  os_type = "linux"

  flavor = "ccd.Large"
  image  = "CentOS_Stream9_May2026"

  vpc_name    = "production"
  subnet_name = "private"

  availability_zone = "S1"
  keypair_name      = "platform-key"
}
```

### Linux VM with Admin Credentials

```hcl
module "vm" {
  source = "Airtel-Cloud-Platform/virtual-machines/airtelcloud"

  vm_name = "linux-app01"
  os_type = "linux"

  flavor = "ccd.Large"
  image  = "CentOS_Stream9_May2026"

  vpc_name    = "production"
  subnet_name = "private"

  availability_zone = "S1"

  admin_username = "terraform"
  admin_password = "StrongPassword@123"
}
```

### Linux VM Complete Example

```hcl
module "linux_vm_complete" {
  source = "Airtel-Cloud-Platform/virtual-machines/airtelcloud"

  vm_name = "linux-prod-app01"
  os_type = "linux"

  flavor = "ccd.XLarge"
  image  = "CentOS_Stream9_May2026"

  vpc_name    = "production"
  subnet_name = "private"

  security_group_names = ["default"]
  availability_zone    = "S1"

  admin_username = "terraform"
  admin_password = "StrongPassword@123"

  disk_size        = 20
  boot_from_volume = true

  user_data = <<-EOT
    #!/bin/bash
    yum install -y nginx
    systemctl enable nginx
    systemctl start nginx
  EOT

  enable_backup   = true
  protection_plan = "plan-id-or-uuid"
  weekday         = "monday"
  start_time      = "02:00"

  description = "Linux production VM using username/password authentication"
  labels      = ["prod", "web", "platform"]
}
```

### Windows VM Basic Example

```hcl
module "vm" {
  source = "Airtel-Cloud-Platform/virtual-machines/airtelcloud"

  vm_name = "windows-app01"
  os_type = "windows"

  flavor = "ccd.Large"
  image  = "WIN2K19_PREACT_Jul2026"

  vpc_name    = "production"
  subnet_name = "private"

  availability_zone = "S1"
}
```

### Snapshot-Based Image Example

```hcl
module "vm" {
  source = "Airtel-Cloud-Platform/virtual-machines/airtelcloud"

  vm_name = "snapshot-vm"
  os_type = "linux"

  flavor        = "ccd.Large"
  snapshot_name = "golden-linux-snapshot"

  vpc_name    = "production"
  subnet_name = "private"

  availability_zone = "S1"
  keypair_name      = "platform-key"
}
```

---

## Authentication Rules

- For Linux VMs, you must provide one authentication method:
  - keypair_name
  - admin_username and admin_password together
- Do not combine keypair and admin credentials in the same request.
- For Windows VMs, admin_username/admin_password are not required by this module.

---

## Name-Only Inputs

This module accepts name-based inputs only for VM lookup and resolution:

- flavor
- image or snapshot_name
- vpc_name
- subnet_name
- security_group_names
- keypair_name

---

## Backup Inputs

- protection_plan expects the plan ID/UUID.
- Use either start_date or weekday (not both).
- start_time accepts HH:MM (24-hour format).

---

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| vm_name | Virtual machine name | string | n/a |
| os_type | Operating system type (linux/windows) | string | n/a |
| flavor | Flavor name | string | n/a |
| image | Image name | string | null |
| snapshot_name | Snapshot name | string | null |
| vpc_name | VPC name | string | n/a |
| subnet_name | Subnet name | string | n/a |
| availability_zone | Availability zone | string | null |
| region | Region (defaults to provider region) | string | null |
| vm_count | Number of VMs to create (1-10) | number | 1 |
| security_group_names | Security group names | list(string) | null |
| keypair_name | Keypair name | string | null |
| admin_username | Linux admin username | string | null |
| admin_password | Linux admin password | string | null |
| boot_from_volume | Boot from volume | bool | true |
| disk_size | Boot disk size in GB | number | 20 |
| user_data | Cloud-init/bootstrap script | string | null |
| description | VM description | string | "" |
| labels | VM labels | list(string) | null |
| enable_backup | Enable VM backup | bool | false |
| protection_plan | Backup protection plan ID/UUID | string | null |
| start_date | Backup start date | string | null |
| weekday | Backup weekday | string | null |
| start_time | Backup start time | string | null |
| timeouts | Terraform resource timeouts | object({ create = optional(string), delete = optional(string) }) | null |

---

## Outputs

| Name | Description |
|------|-------------|
| id | VM ID |
| provider_instance_id | Provider instance ID |
| instance_name | VM name |
| status | VM status |
| public_ip | Public IP address |
| private_ip | Private IP address |
| availability_zone | Availability zone |
| region | Region |

---

## Notes

- Validate inputs with `terraform validate` before apply.
- Keep secrets like admin_password in secure variable handling (for example, environment variables or secret managers).
