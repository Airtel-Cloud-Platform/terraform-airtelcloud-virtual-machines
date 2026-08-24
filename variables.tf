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
  description = "Operating system type. Supported values: linux, windows."
  type        = string

  validation {
    condition = contains(
      ["linux", "windows"],
      lower(var.os_type)
    )

    error_message = "os_type must be either linux or windows."
  }
}

#########################################
# Flavor
#########################################

variable "flavor" {
  description = "Flavor name. Mutually exclusive with flavor_id."
  type        = string
  default     = null
}

variable "flavor_id" {
  description = "Flavor ID. Mutually exclusive with flavor."
  type        = string
  default     = null

  validation {
    condition = length(compact([
      var.flavor,
      var.flavor_id,
    ])) == 1

    error_message = "Specify exactly one of flavor or flavor_id."
  }
}

#########################################
# Image
#########################################

variable "image" {
  description = "Image name. Mutually exclusive with image_id and snapshot_name."
  type        = string
  default     = null

  validation {
    condition = length(compact([
      var.image,
      var.image_id,
      var.snapshot_name,
    ])) == 1

    error_message = "Specify exactly one of image, image_id, or snapshot_name."
  }
}

variable "image_id" {
  description = "Image ID. Mutually exclusive with image and snapshot_name."
  type        = string
  default     = null
}

variable "snapshot_name" {
  description = "Snapshot name. Mutually exclusive with image and image_id."
  type        = string
  default     = null
}

#########################################
# Networking
#########################################

variable "vpc_id" {
  description = "VPC ID."
  type        = string
  default     = null
}

variable "vpc_name" {
  description = "VPC Name."
  type        = string
  default     = null

  validation {
    condition = length(compact([
      var.vpc_id,
      var.vpc_name,
    ])) == 1

    error_message = "Specify exactly one of vpc_id or vpc_name."
  }
}

variable "subnet_id" {
  description = "Subnet ID."
  type        = string
  default     = null
}

variable "subnet_name" {
  description = "Subnet Name."
  type        = string
  default     = null

  validation {
    condition = length(compact([
      var.subnet_id,
      var.subnet_name,
    ])) == 1

    error_message = "Specify exactly one of subnet_id or subnet_name."
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

variable "security_group_ids" {
  description = "Security Group IDs."
  type        = list(string)
  default     = null

  validation {
    condition = (
      var.security_group_ids == null ||
      alltrue([for sg in var.security_group_ids : length(trim(sg, " ")) > 0])
    )

    error_message = "security_group_ids must not contain empty values."
  }
}

variable "security_group_names" {
  description = "Security Group Names."
  type        = list(string)
  default     = null

  validation {
    condition = !(
      var.security_group_ids != null &&
      var.security_group_names != null
    )

    error_message = "Specify either security_group_ids or security_group_names, not both."
  }

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

variable "keypair_id" {
  description = "Keypair ID."
  type        = string
  default     = null
}

variable "keypair_name" {
  description = "Keypair Name."
  type        = string
  default     = null

  validation {
    condition = !(
      var.keypair_id != null &&
      var.keypair_name != null
    )

    error_message = "Specify either keypair_id or keypair_name, not both."
  }
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
      (var.keypair_id != null || var.keypair_name != null)
    )

    error_message = "Use either admin credentials or keypair input, not both."
  }

  validation {
    condition = (
      lower(var.os_type) != "linux" ||
      var.keypair_id != null ||
      var.keypair_name != null ||
      (var.admin_username != null && var.admin_password != null)
    )

    error_message = "For linux os_type, provide either keypair input or admin credentials."
  }

  validation {
    condition = (
      (var.admin_username == null && var.admin_password == null) ||
      lower(var.os_type) == "linux"
    )

    error_message = "admin_username/admin_password are only supported when os_type is linux."
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

variable "volume_type_id" {
  description = "Volume Type ID."
  type        = string
  default     = null
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
  description = "Backup protection plan ID/UUID."
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
