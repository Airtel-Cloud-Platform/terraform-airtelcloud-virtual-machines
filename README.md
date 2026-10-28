# Airtel Cloud Virtual Machine Terraform Module

This Terraform module provisions Airtel Cloud VMs using the `airtelcloud_vm` resource in the provider.

## Supported behavior

- Create a VM from an image or snapshot
- Use Linux keypair authentication or Linux admin credentials
- Attach security groups by name
- Optionally enable backup settings and labels
- Keep the module input surface clean and provider-friendly

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.5 |
| airtelcloud provider | >= 1.1.3 |

## Usage

### Basic example

```hcl
module "vm" {
  source = "Airtel-Cloud-Platform/virtual-machines/airtelcloud"

  instance_name = "web01"
  os_type       = "linux"

  flavor_name = "ccd.Large"
  image_name  = "Ubuntu22_04_Jul2026"

  vpc_name    = "production"
  subnet_name = "private"

  availability_zone = "S1"
  keypair_name      = "platform-key"
}
```

### Linux VM with admin credentials

```hcl
module "linux_vm" {
  source = "Airtel-Cloud-Platform/virtual-machines/airtelcloud"

  instance_name = "linux-app01"
  os_type       = "linux"

  flavor_name = "ccd.Large"
  image_name  = "Ubuntu22_04_Jul2026"

  vpc_name    = "production"
  subnet_name = "private"

  admin_username = "terraform"
  admin_password = "StrongPassword@123"

  availability_zone = "S1"
  disk_size         = 100
}
```

### Snapshot-based VM

```hcl
module "snapshot_vm" {
  source = "Airtel-Cloud-Platform/virtual-machines/airtelcloud"

  instance_name = "snapshot-vm"
  os_type       = "linux"

  flavor_name   = "ccd.Large"
  snapshot_name = "golden-linux-snapshot"

  vpc_name    = "production"
  subnet_name = "private"

  availability_zone = "S1"
  keypair_name      = "platform-key"
}
```

## Authentication rules

- For Linux VMs, use one path only:
  - `keypair_name`
  - or `admin_username` + `admin_password`
- Do not combine keypair auth and admin credentials in the same VM.
- Windows examples normally use the platform default path without admin credential injection.

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| instance_name | VM instance name | string | null |
| vm_name | Deprecated alias for instance_name | string | null |
| os_type | VM OS type | string | required |
| flavor_name | Flavor name | string | null |
| image_name | Image name | string | null |
| snapshot_name | Snapshot name | string | null |
| vpc_name | VPC name | string | null |
| subnet_name | Subnet name | string | null |
| security_group_names | Security group names | list(string) | null |
| keypair_name | Keypair name | string | null |
| admin_username | Linux admin username | string | null |
| admin_password | Linux admin password | string | null |
| availability_zone | Availability zone | string | null |
| region | Region override | string | null |
| vm_count | Number of VMs to create | number | 1 |
| boot_from_volume | Boot the VM from a volume | bool | true |
| disk_size | Boot disk size in GB | number | 20 |
| user_data | Cloud-init or bootstrap script | string | null |
| description | VM description | string | "" |
| labels | Labels to assign | list(string) | null |
| enable_backup | Enable backup | bool | false |
| protection_plan | Backup plan UUID or name | string | null |
| start_date | Backup start date | string | null |
| weekday | Backup weekday | string | null |
| start_time | Backup start time | string | null |
| timeouts | Terraform create/delete timeouts | object | null |

## Outputs

| Name | Description |
|------|-------------|
| id | VM ID |
| provider_instance_id | Provider-specific instance ID |
| instance_name | VM name |
| status | VM status |
| public_ip | Public IP |
| private_ip | Private IP |
| availability_zone | Availability zone |
| region | Region |

## Notes

- This module intentionally keeps the interface simple and follows the provider’s supported VM patterns instead of exposing every low-level provider detail.
- Prefer `instance_name` for new configurations; the legacy `vm_name` alias is kept only for compatibility.
- Validate inputs with `terraform validate` before apply.
- Keep secrets like admin_password in secure variable handling (for example, environment variables or secret managers).
