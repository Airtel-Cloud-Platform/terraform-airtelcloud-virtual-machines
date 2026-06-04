module "vm" {
  source = "../../"

  vm_name = "web01"

  os_type = "linux"

  flavor = "ccd.Large"
  image  = "CentOS_Stream9_May2026"

  vpc_id    = "vpc-id"
  subnet_id = "subnet-id"

  availability_zone = "S1"
}
