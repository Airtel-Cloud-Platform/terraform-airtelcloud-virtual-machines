locals {
  use_snapshot          = var.snapshot_name != null
  use_admin_credentials = var.admin_username != null || var.admin_password != null
}

resource "airtelcloud_vm" "keypair_image" {
  count = !local.use_snapshot && !local.use_admin_credentials ? 1 : 0

  instance_name = var.vm_name
  os_type       = var.os_type

  flavor_name = var.flavor
  image_name  = var.image

  vpc_name    = var.vpc_name
  subnet_name = var.subnet_name

  security_group_names = var.security_group_names

  keypair_name = var.keypair_name

  user_data        = var.user_data
  boot_from_volume = var.boot_from_volume
  disk_size        = var.disk_size

  availability_zone = var.availability_zone
  region            = var.region
  vm_count          = var.vm_count

  description = var.description
  labels      = var.labels

  enable_backup   = var.enable_backup
  protection_plan = var.protection_plan
  start_date      = var.start_date
  weekday         = var.weekday
  start_time      = var.start_time

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = try(timeouts.value.create, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}

resource "airtelcloud_vm" "keypair_snapshot" {
  count = local.use_snapshot && !local.use_admin_credentials ? 1 : 0

  instance_name = var.vm_name
  os_type       = var.os_type

  flavor_name   = var.flavor
  snapshot_name = var.snapshot_name

  vpc_name    = var.vpc_name
  subnet_name = var.subnet_name

  security_group_names = var.security_group_names

  keypair_name = var.keypair_name

  user_data        = var.user_data
  boot_from_volume = var.boot_from_volume
  disk_size        = var.disk_size

  availability_zone = var.availability_zone
  region            = var.region
  vm_count          = var.vm_count

  description = var.description
  labels      = var.labels

  enable_backup   = var.enable_backup
  protection_plan = var.protection_plan
  start_date      = var.start_date
  weekday         = var.weekday
  start_time      = var.start_time

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = try(timeouts.value.create, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}

resource "airtelcloud_vm" "admin_image" {
  count = !local.use_snapshot && local.use_admin_credentials ? 1 : 0

  instance_name = var.vm_name
  os_type       = var.os_type

  flavor_name = var.flavor
  image_name  = var.image

  vpc_name    = var.vpc_name
  subnet_name = var.subnet_name

  security_group_names = var.security_group_names

  admin_username = var.admin_username
  admin_password = var.admin_password

  user_data        = var.user_data
  boot_from_volume = var.boot_from_volume
  disk_size        = var.disk_size

  availability_zone = var.availability_zone
  region            = var.region
  vm_count          = var.vm_count

  description = var.description
  labels      = var.labels

  enable_backup   = var.enable_backup
  protection_plan = var.protection_plan
  start_date      = var.start_date
  weekday         = var.weekday
  start_time      = var.start_time

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = try(timeouts.value.create, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}

resource "airtelcloud_vm" "admin_snapshot" {
  count = local.use_snapshot && local.use_admin_credentials ? 1 : 0

  instance_name = var.vm_name
  os_type       = var.os_type

  flavor_name   = var.flavor
  snapshot_name = var.snapshot_name

  vpc_name    = var.vpc_name
  subnet_name = var.subnet_name

  security_group_names = var.security_group_names

  admin_username = var.admin_username
  admin_password = var.admin_password

  user_data        = var.user_data
  boot_from_volume = var.boot_from_volume
  disk_size        = var.disk_size

  availability_zone = var.availability_zone
  region            = var.region
  vm_count          = var.vm_count

  description = var.description
  labels      = var.labels

  enable_backup   = var.enable_backup
  protection_plan = var.protection_plan
  start_date      = var.start_date
  weekday         = var.weekday
  start_time      = var.start_time

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = try(timeouts.value.create, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}
