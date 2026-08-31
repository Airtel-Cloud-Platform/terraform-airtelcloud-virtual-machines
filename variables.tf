#########################################
# Basic Configuration
#########################################

variable "vm_name" {
  description = "Virtual machine name."
  type        = string

  validation {
    condition     = length(trim(var.vm_name, " ")) > 0
    error_message = "vm_name cannot be empty."
  }
}

variable "os_type" {
  description = "Operating system type. Supported values: linux, ubuntu, rhel, suse, centos, windows."
  type        = string

  validation {
    condition = contains(
      ["linux", "ubuntu", "rhel", "suse", "centos", "windows"],
      lower(var.os_type)
    )

    error_message = "os_type must be one of: linux, ubuntu, rhel, suse, centos, windows."
  }
}

#########################################
# Flavor
#########################################

variable "flavor" {
  description = "Flavor name."
  type        = string

  validation {
    condition     = length(trim(var.flavor, " ")) > 0
    error_message = "flavor cannot be empty."
  }
}

#########################################
# Image
#########################################

variable "image" {
  description = "Image name. Mutually exclusive with snapshot_name."
  type        = string
  default     = null

  validation {
    condition = length(compact([
      var.image,
      var.snapshot_name,
    ])) == 1

    error_message = "Specify exactly one of image or snapshot_name."
  }
}

variable "snapshot_name" {
  description = "Snapshot name. Mutually exclusive with image."
  type        = string
  default     = null
}

#########################################
# Networking
#########################################

variable "vpc_name" {
  description = "VPC Name."
  type        = string

  validation {
    condition     = length(trim(var.vpc_name, " ")) > 0
    error_message = "vpc_name cannot be empty."
  }
}

variable "subnet_name" {
  description = "Subnet Name."
  type        = string

  validation {
    condition     = length(trim(var.subnet_name, " ")) > 0
    error_message = "subnet_name cannot be empty."
  }
}

#########################################
# Placement
#########################################

variable "availability_zone" {
  description = "Availability Zone."
  type        = string
  default     = null
}

variable "region" {
  description = "Region. Defaults to provider region."
  type        = string
  default     = null
}

variable "vm_count" {
  description = "Number of VM instances to create."
  type        = number
  default     = 1

  validation {
    condition     = var.vm_count >= 1 && var.vm_count <= 10
    error_message = "vm_count must be between 1 and 10."
  }
}

#########################################
# Security Group
#########################################

variable "security_group_names" {
  description = "Security Group Names."
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

#########################################
# Authentication
#########################################

variable "keypair_name" {
  description = "Keypair Name."
  type        = string
  default     = null
}

variable "admin_username" {
  description = "Linux administrator username."
  type        = string
  default     = null

  validation {
    condition = (
      var.admin_username == null ||
      length(trim(var.admin_username, " ")) > 0
    )

    error_message = "admin_username may not be an empty string."
  }
}

variable "admin_password" {
  description = "Linux administrator password."
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
    condition = !(
      (var.admin_username != null || var.admin_password != null) &&
      var.keypair_name != null
    )

    error_message = "Use either admin credentials or keypair input, not both."
  }

  validation {
    condition = (
      lower(var.os_type) == "windows" ||
      var.keypair_name != null ||
      (var.admin_username != null && var.admin_password != null)
    )

    error_message = "For non-windows os_type, provide either keypair_name or admin credentials."
  }

  validation {
    condition = (
      (var.admin_username == null && var.admin_password == null) ||
      lower(var.os_type) != "windows"
    )

    error_message = "admin_username/admin_password are not supported when os_type is windows."
  }

  validation {
    condition = (
      var.admin_password == null ||
      length(trim(var.admin_password, " ")) > 0
    )

    error_message = "admin_password may not be an empty string."
  }
}

#########################################
# Boot Configuration
#########################################

variable "boot_from_volume" {
  description = "Boot instance from volume."
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

variable "user_data" {
  description = "Cloud-init / bootstrap script."
  type        = string
  default     = null
}

#########################################
# Metadata
#########################################

variable "description" {
  description = "Virtual machine description."
  type        = string
  default     = ""
}

variable "labels" {
  description = "Labels to assign to the VM."
  type        = list(string)
  default     = null

  validation {
    condition = (
      var.labels == null ||
      length(var.labels) <= 5
    )

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

#########################################
# Backup
#########################################

variable "enable_backup" {
  description = "Enable VM backup."
  type        = bool
  default     = false
}

variable "protection_plan" {
  description = "Backup protection plan UUID or name. The provider accepts either format."
  type        = string
  default     = null
}

variable "start_date" {
  description = "Backup start date."
  type        = string
  default     = null
}

variable "weekday" {
  description = "Backup weekday. Mutually exclusive with start_date."
  type        = string
  default     = null

  validation {
    condition = !(
      var.start_date != null &&
      var.weekday != null
    )

    error_message = "Specify either start_date or weekday, not both."
  }
}

variable "start_time" {
  description = "Backup start time."
  type        = string
  default     = null
}

#########################################
# Timeouts
#########################################

variable "timeouts" {
  description = "Terraform resource timeouts."

  type = object({
    create = optional(string)
    delete = optional(string)
  })

  default = null
}
