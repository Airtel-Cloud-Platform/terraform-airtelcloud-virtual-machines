variable "vm_name" {
  description = "Virtual machine name"
  type        = string

  validation {
    condition     = length(trim(var.vm_name, " ")) > 0
    error_message = "vm_name cannot be empty."
  }
}

variable "os_type" {
  description = "Operating system type"
  type        = string

  validation {
    condition = contains(
      ["linux", "windows"],
      lower(var.os_type)
    )

    error_message = "os_type must be either linux or windows."
  }
}

variable "flavor" {
  description = "VM flavor"
  type        = string

  validation {
    condition     = length(trim(var.flavor, " ")) > 0
    error_message = "flavor cannot be empty."
  }
}

variable "image" {
  description = "VM image"
  type        = string

  validation {
    condition     = length(trim(var.image, " ")) > 0
    error_message = "image cannot be empty."
  }
}

variable "vpc_id" {
  description = "Target VPC ID"
  type        = string

  validation {
    condition     = length(trim(var.vpc_id, " ")) > 0
    error_message = "vpc_id cannot be empty."
  }
}

variable "subnet_id" {
  description = "Target subnet ID"
  type        = string

  validation {
    condition     = length(trim(var.subnet_id, " ")) > 0
    error_message = "subnet_id cannot be empty."
  }
}

variable "availability_zone" {
  description = "Availability zone"
  type        = string

  validation {
    condition     = length(trim(var.availability_zone, " ")) > 0
    error_message = "availability_zone cannot be empty."
  }
}

variable "boot_from_volume" {
  description = "Whether VM should boot from volume"
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "Boot disk size in GB"
  type        = number
  default     = 100

  validation {
    condition     = var.disk_size >= 100
    error_message = "disk_size must be greater than or equal to 100 GB."
  }
}

variable "description" {
  description = "VM description"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to the VM"
  type        = map(string)
  default     = {}
}
variable "security_group_id" {
  description = "Security Group ID to attach to VM"
  type        = string
  default     = null
}

variable "keypair_id" {
  description = "Keypair ID for SSH access"
  type        = string
  default     = null
}


variable "user_data" {
  description = "Cloud-init or bootstrap script"
  type        = string
  default     = null
}

variable "volume_type_id" {
  description = "Volume type ID"
  type        = string
  default     = null
}

variable "enable_backup" {
  description = "Enable VM backup"
  type        = bool
  default     = false
}

variable "protection_plan" {
  description = "Protection plan name"
  type        = string
  default     = null
}

variable "start_date" {
  description = "Backup start date"
  type        = string
  default     = null
}

variable "start_time" {
  description = "Backup start time"
  type        = string
  default     = null
}

