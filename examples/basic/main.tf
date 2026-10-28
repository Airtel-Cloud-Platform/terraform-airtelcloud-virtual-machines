module "vm" {
  source = "../../"

  instance_name = "web01"
  os_type       = "linux"

  flavor_name = "ccd.Large"
  image_name  = "CentOS_Stream9_May2026"

  vpc_name    = "production"
  subnet_name = "private"

  availability_zone = "S1"
  keypair_name      = "platform-key"
}
