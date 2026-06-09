resource "airtelcloud_vm" "this" {
  instance_name = var.vm_name

  os_type = var.os_type

  flavor_name = var.flavor
  image_name  = var.image

  vpc_id    = var.vpc_id
  subnet_id = var.subnet_id

  security_group_id = var.security_group_id

  keypair_id = var.keypair_id

  user_data      = var.user_data
  volume_type_id = var.volume_type_id

  boot_from_volume = var.boot_from_volume
  disk_size        = var.disk_size

  availability_zone = var.availability_zone
  description       = var.description

  enable_backup   = var.enable_backup
  protection_plan = var.protection_plan
  start_date      = var.start_date
  start_time      = var.start_time


  tags = var.tags
}


