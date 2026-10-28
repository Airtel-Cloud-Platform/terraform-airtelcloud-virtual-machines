module "vm" {
  source = "../../"

  instance_name = "web-server-keypair"
  os_type       = "linux"

  flavor_name = "ccd.Large"
  image_name  = "Ubuntu22_04_Jul2026"

  vpc_name    = "vpc01"
  subnet_name = "sub1"

  security_group_names = ["all-open-az1"]
  availability_zone    = "S1"
  boot_from_volume     = true
  disk_size            = 120
  volume_type_id       = "31"
  keypair_name         = "my-linux-keypair"

  labels = ["production", "keypair-auth", "api"]
}
