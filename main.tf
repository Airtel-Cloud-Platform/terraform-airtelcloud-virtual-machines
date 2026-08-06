resource "airtelcloud_vm" "this" {

  #####################################
  # Basic Configuration
  #####################################

  instance_name = var.vm_name

  os_type = var.os_type

  flavor_id   = var.flavor_id
  flavor_name = var.flavor_id == null ? var.flavor : null

  image_id   = var.image_id
  image_name = var.image_id == null ? var.image : null

  #####################################
  # Networking
  #####################################

  vpc_id   = var.vpc_id
  vpc_name = var.vpc_id == null ? var.vpc_name : null

  subnet_id   = var.subnet_id
  subnet_name = var.subnet_id == null ? var.subnet_name : null

  #####################################
  # Security
  #####################################

  security_group_id   = var.security_group_id
  security_group_name = var.security_group_id == null ? var.security_group_name : null

  #####################################
  # Authentication
  #####################################

  keypair_id   = var.keypair_id
  keypair_name = var.keypair_id == null ? var.keypair_name : null

  admin_username = var.admin_username
  admin_password = var.admin_password

  #####################################
  # Boot Configuration
  #####################################

  user_data = var.user_data

  boot_from_volume = var.boot_from_volume

  disk_size = var.disk_size

  volume_type_id = var.volume_type_id

  #####################################
  # Placement
  #####################################

  availability_zone = var.availability_zone

  region = var.region

  #####################################
  # Metadata
  #####################################

  description = var.description

  tags = var.tags

  #####################################
  # Backup
  #####################################

  enable_backup = var.enable_backup

  protection_plan = var.protection_plan

  start_date = var.start_date

  start_time = var.start_time

  #####################################
  # Timeouts
  #####################################

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = try(timeouts.value.create, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}
