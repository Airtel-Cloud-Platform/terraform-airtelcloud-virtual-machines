locals {
  vm = try(
    airtelcloud_vm.keypair_image[0],
    airtelcloud_vm.keypair_snapshot[0],
    airtelcloud_vm.admin_image[0],
    airtelcloud_vm.admin_snapshot[0],
  )
}

output "id" {
  description = "VM ID."
  value       = local.vm.id
}

output "provider_instance_id" {
  description = "Provider instance ID."
  value       = local.vm.provider_instance_id
}

output "instance_name" {
  description = "VM name."
  value       = local.vm.instance_name
}

output "status" {
  description = "Current VM status."
  value       = local.vm.status
}

output "public_ip" {
  description = "Public IP address."
  value       = local.vm.public_ip
}

output "private_ip" {
  description = "Private IP address."
  value       = local.vm.private_ip
}

output "availability_zone" {
  description = "Availability Zone."
  value       = local.vm.availability_zone
}

output "region" {
  description = "Cloud Region."
  value       = local.vm.region
}
