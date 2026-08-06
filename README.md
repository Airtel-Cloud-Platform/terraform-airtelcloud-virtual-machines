# Airtel Cloud Virtual Machine Terraform Module

This Terraform module provisions Virtual Machines (VMs) on Airtel Cloud using the `airtelcloud_vm` resource.

The module supports all capabilities currently available in the Airtel Cloud Terraform Provider, including:

- VM creation
- Boot from volume
- Image by ID or Name
- Flavor by ID or Name
- VPC by ID or Name
- Subnet by ID or Name
- Security Group by ID or Name
- Keypair by ID or Name
- Username/Password authentication
- Backup configuration
- Cloud-init (User Data)
- Tags
- Timeouts

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

# Usage

## Basic Example

```hcl
module "vm" {

  source = "Airtel-Cloud-Platform/virtual-machines/airtelcloud"

  vm_name = "web01"

  os_type = "linux"

  flavor = "ccd.Large"

  image = "CentOS_Stream9_May2026"

  vpc_name = "production"

  subnet_name = "private"

  availability_zone = "S1"

  keypair_name = "platform-key"

}
```

---

## Complete Example

```hcl
module "vm" {

  source = "Airtel-Cloud-Platform/virtual-machines/airtelcloud"

  vm_name = "production-web"

  os_type = "linux"

  flavor = "ccd.XLarge"

  image = "CentOS_Stream9_May2026"

  vpc_name = "production"

  subnet_name = "private"

  security_group_name = "default"

  keypair_name = "platform-key"

  availability_zone = "S1"

  disk_size = 100

  boot_from_volume = true

  enable_backup = true

  protection_plan = "daily"

  start_date = "2026-06-01"

  start_time = "02:00"

  tags = {
    Environment = "Production"
    Team        = "Platform"
  }

}
```

---

# Authentication Options

The module supports both authentication methods supported by the provider.

## SSH Keypair

```hcl
keypair_id = "xxxxx"
```

or

```hcl
keypair_name = "platform-key"
```

---

## Username / Password

```hcl
admin_username = "terraform"

admin_password = "Password@123"
```

---

# Network Selection

Resources can be referenced either by **ID** or by **Name**.

Example:

```hcl
vpc_id = "123"
```

or

```hcl
vpc_name = "production"
```

The same applies to:

- Flavor
- Image
- VPC
- Subnet
- Security Group
- Keypair

---

# Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| vm_name | VM Name | string | n/a |
| os_type | linux/windows | string | n/a |
| flavor | Flavor Name | string | null |
| flavor_id | Flavor ID | string | null |
| image | Image Name | string | null |
| image_id | Image ID | string | null |
| vpc_id | VPC ID | string | null |
| vpc_name | VPC Name | string | null |
| subnet_id | Subnet ID | string | null |
| subnet_name | Subnet Name | string | null |
| security_group_id | Security Group ID | string | null |
| security_group_name | Security Group Name | string | null |
| keypair_id | Keypair ID | string | null |
| keypair_name | Keypair Name | string | null |
| admin_username | Admin Username | string | null |
| admin_password | Admin Password | string | null |
| availability_zone | Availability Zone | string | null |
| region | Region | string | null |
| disk_size | Disk Size (GB) | number | 100 |
| boot_from_volume | Boot From Volume | bool | true |
| volume_type_id | Volume Type ID | string | null |
| user_data | Cloud Init | string | null |
| description | VM Description | string | "" |
| enable_backup | Enable Backup | bool | false |
| protection_plan | Backup Policy | string | null |
| start_date | Backup Date | string | null |
| start_time | Backup Time | string | null |
| tags | Tags | map(string) | {} |

---

# Outputs

| Name | Description |
|------|-------------|
| id | VM ID |
| provider_instance_id | Provider Instance ID |
| instance_name | VM Name |
| status | Current VM Status |
| public_ip | Public IP |
| private_ip | Private IP |
| availability_zone | Availability Zone |
| region | Region |

---

# Notes

- Either ID or Name can be used for supported resources.
- Existing users can continue using `flavor` and `image`; these map internally to the provider's `flavor_name` and `image_name`.
- Username/password authentication is supported only for Linux VMs, as enforced by the provider.
- The module intentionally does not expose `vm_count` because of the provider behavior you previously observed with resource destruction.
