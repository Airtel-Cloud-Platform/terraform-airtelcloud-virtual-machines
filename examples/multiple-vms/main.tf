locals {
  vms = {
    web01 = {
      flavor = "ccd.Large"
    }
    web02 = {
      flavor = "ccd.Large"
    }
    web03 = {
      flavor = "ccd.XLarge"
    }
  }
}

module "vm" {
  for_each = local.vms

  source = "../../"

  instance_name = each.key
  os_type       = "linux"

  flavor_name = each.value.flavor
  image_name  = "CentOS_Stream9_May2026"

  vpc_name    = "production"
  subnet_name = "private"

  availability_zone = "S1"
  keypair_name      = "platform-key"
}
