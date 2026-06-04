module "vm" {
  source = "../../"

  vm_name = "production-web01"

  os_type = "linux"

  flavor = "ccd.Large"
  image  = "CentOS_Stream9_Mar2026"

  vpc_id    = "vpc-id"
  subnet_id = "subnet-id"

  security_group_id = "sg-id"

  availability_zone = "S2"

  boot_from_volume = true
  disk_size        = 100

  keypair_id = "keypair-id"

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello World"
  EOF

  enable_backup   = true
  protection_plan = "daily"

  start_date = "2026-06-01"
  start_time = "02:00"


  tags = {
    Environment = "production"
    Application = "web"
    Owner       = "platform-team"
  }
}
