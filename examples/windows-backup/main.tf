module "vm" {
  source = "../../"

  instance_name = "win-server"
  os_type       = "windows"

  flavor_name = "ccd.Large"
  image_name  = "WIN2K19_PREACT_Jul2026"

  vpc_name    = "vpc01"
  subnet_name = "sub1"

  security_group_names = ["all-open-az1"]
  availability_zone    = "N1"
  disk_size            = 100
  boot_from_volume     = true
  enable_backup        = true
  protection_plan      = "S2-ELEMENTS-COPPER-TFT-DAILY-BACKUP-BKP-PP"
  weekday              = "monday"
  start_time           = "02:00"

  labels = ["production", "windows", "backup"]
}
