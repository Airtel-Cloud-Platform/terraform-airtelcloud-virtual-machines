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

  validation {
    condition = !(
      var.flavor != null &&
      var.flavor_id != null
    )

    error_message = "Specify either flavor or flavor_id, not both."
  }
}

variable "flavor_id" {
  description = "Flavor ID. Mutually exclusive with flavor."
  type        = string
  default     = null
}

#########################################
# Image
#########################################

variable "image" {
  description = "Image name. Mutually exclusive with image_id."
  type        = string
  default     = null

  validation {
    condition = !(
      var.image != null &&
      var.image_id != null
    )

    error_message = "Specify either image or image_id, not both."
  }
}

variable "image_id" {
  description = "Image ID. Mutually exclusive with image."
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
    condition = !(
      var.vpc_id != null &&
      var.vpc_name != null
    )

    error_message = "Specify either vpc_id or vpc_name, not both."
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
    condition = !(
      var.subnet_id != null &&
      var.subnet_name != null
    )

    error_message = "Specify either subnet_id or subnet_name, not both."
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

#########################################
# Security Group
#########################################

variable "security_group_id" {
  description = "Security Group ID."
  type        = string
  default     = null
}

variable "security_group_name" {
  description = "Security Group Name."
  type        = string
  default     = null

  validation {
    condition = !(
      var.security_group_id != null &&
      var.security_group_name != null
    )

    error_message = "Specify either security_group_id or security_group_name, not both."
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
}

variable "admin_password" {
  description = "Linux administrator password."
  type        = string
  default     = null
  sensitive   = true
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
  default     = 100

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

variable "tags" {
  description = "Tags to assign to the VM."
  type        = map(string)
  default     = {}
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
  description = "Backup protection plan."
  type        = string
  default     = null
}

variable "start_date" {
  description = "Backup start date."
  type        = string
  default     = null
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
