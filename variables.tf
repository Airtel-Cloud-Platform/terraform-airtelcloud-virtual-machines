variable "instance_name" {
  description = "VM instance name. Use this in new code."
  type        = string
  default     = null
}

variable "vm_name" {
  description = "Deprecated alias for instance_name."
  type        = string
  default     = null
}

variable "os_type" {
  description = "Operating system type. Supported values: linux, ubuntu, rhel, suse, centos, windows."
  type        = string

  validation {
    condition = contains([
      "linux", "ubuntu", "rhel", "suse", "centos", "windows"
    ], lower(var.os_type))

    error_message = "os_type must be one of: linux, ubuntu, rhel, suse, centos, windows."
  }
}

variable "flavor_name" {
  description = "Flavor name."
  type        = string
  default     = null

  validation {
    condition     = var.flavor_name == null || length(trim(var.flavor_name, " ")) > 0
    error_message = "flavor_name cannot be empty."
  }
}

variable "image_name" {
  description = "Image name. Mutually exclusive with snapshot_name."
  type        = string
  default     = null

  validation {
    condition     = var.image_name == null || length(trim(var.image_name, " ")) > 0
    error_message = "image_name cannot be empty."
  }
}

variable "snapshot_name" {
  description = "Snapshot name. Mutually exclusive with image_name."
  type        = string
  default     = null

  validation {
    condition     = var.snapshot_name == null || length(trim(var.snapshot_name, " ")) > 0
    error_message = "snapshot_name cannot be empty."
  }
}

variable "vpc_name" {
  description = "VPC name."
  type        = string
  default     = null

  validation {
    condition     = var.vpc_name == null || length(trim(var.vpc_name, " ")) > 0
    error_message = "vpc_name cannot be empty."
  }
}

variable "subnet_name" {
  description = "Subnet name."
  type        = string
  default     = null

  validation {
    condition     = var.subnet_name == null || length(trim(var.subnet_name, " ")) > 0
    error_message = "subnet_name cannot be empty."
  }
}

variable "security_group_names" {
  description = "Security group names to attach to the VM."
  type        = list(string)
  default     = null

  validation {
    condition = (
      var.security_group_names == null ||
      alltrue([for sg in var.security_group_names : length(trim(sg, " ")) > 0])
    )
    error_message = "security_group_names must not contain empty values."
  }
}

variable "keypair_name" {
  description = "Keypair name for SSH authentication."
  type        = string
  default     = null
}

variable "admin_username" {
  description = "Linux administrator username. Use with admin_password."
  type        = string
  default     = null

  validation {
    condition     = var.admin_username == null || length(trim(var.admin_username, " ")) > 0
    error_message = "admin_username may not be an empty string."
  }
}

variable "admin_password" {
  description = "Linux administrator password. Use with admin_username."
  type        = string
  default     = null
  sensitive   = true

  validation {
    condition = (
      (var.admin_username == null && var.admin_password == null) ||
      (var.admin_username != null && var.admin_password != null)
    )
    error_message = "Specify admin_username and admin_password together."
  }

  validation {
    condition = (
      (var.admin_password == null) ||
      length(trim(var.admin_password, " ")) > 0
    )
    error_message = "admin_password may not be empty."
  }
}

variable "user_data" {
  description = "User data or cloud-init bootstrap script."
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "Availability zone where the VM should be provisioned."
  type        = string
  default     = null
}

variable "region" {
  description = "Region override. Defaults to the provider region."
  type        = string
  default     = null
}

variable "vm_count" {
  description = "Number of VM instances to create. Must be between 1 and 10."
  type        = number
  default     = 1

  validation {
    condition     = var.vm_count >= 1 && var.vm_count <= 10
    error_message = "vm_count must be between 1 and 10."
  }
}

variable "boot_from_volume" {
  description = "Whether to boot from volume."
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "Boot disk size in GB."
  type        = number
  default     = 20

  validation {
    condition     = var.disk_size >= 20
    error_message = "disk_size must be greater than or equal to 20 GB."
  }
}

variable "description" {
  description = "VM description."
  type        = string
  default     = ""
}

variable "labels" {
  description = "VM labels to assign. Up to 5 labels are supported."
  type        = list(string)
  default     = null

  validation {
    condition     = var.labels == null || length(var.labels) <= 5
    error_message = "labels supports at most 5 labels."
  }

  validation {
    condition = (
      var.labels == null ||
      alltrue([
        for label in var.labels : length(trim(label, " ")) >= 3 && length(trim(label, " ")) <= 15
      ])
    )
    error_message = "Each label must be between 3 and 15 characters long."
  }
}

variable "enable_backup" {
  description = "Whether backup is enabled for the VM."
  type        = bool
  default     = false
}

variable "protection_plan" {
  description = "Protection plan UUID or plan name."
  type        = string
  default     = null
}

variable "start_date" {
  description = "Backup start date. Mutually exclusive with weekday."
  type        = string
  default     = null
}

variable "weekday" {
  description = "Shortcut for backup scheduling, in place of start_date."
  type        = string
  default     = null

  validation {
    condition     = !(var.start_date != null && var.weekday != null)
    error_message = "Specify either start_date or weekday, not both."
  }
}

variable "start_time" {
  description = "Backup start time in HH:MM format."
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Terraform resource timeouts."
  type = object({
    create = optional(string)
    delete = optional(string)
  })
  default = null
}
