variable "vm_admin_password" {
  description = "Login password for the VM admin user"
  type        = string
  sensitive   = true
}

module "vm" {
  source = "../../"

  instance_name = "web-server-multi-sg"
  os_type       = "linux"

  flavor_name = "ccd.Large"
  image_name  = "Ubuntu22_04_Jul2026"

  vpc_name    = "vpc01"
  subnet_name = "sub1"

  security_group_names = ["all-open-az1", "ssh-open", "app-allow", "db-allow"]
  availability_zone    = "S1"
  boot_from_volume     = true
  disk_size            = 100
  volume_type_id       = "31"
  admin_username       = "clouduser"
  admin_password       = var.vm_admin_password
}
