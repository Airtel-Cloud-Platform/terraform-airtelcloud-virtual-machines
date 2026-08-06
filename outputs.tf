output "id" {
  description = "VM ID."
  value       = airtelcloud_vm.this.id
}

output "provider_instance_id" {
  description = "Provider instance ID."
  value       = airtelcloud_vm.this.provider_instance_id
}

output "instance_name" {
  description = "VM name."
  value       = airtelcloud_vm.this.instance_name
}

output "status" {
  description = "Current VM status."
  value       = airtelcloud_vm.this.status
}

output "public_ip" {
  description = "Public IP address."
  value       = airtelcloud_vm.this.public_ip
}

output "private_ip" {
  description = "Private IP address."
  value       = airtelcloud_vm.this.private_ip
}

output "availability_zone" {
  description = "Availability Zone."
  value       = airtelcloud_vm.this.availability_zone
}

output "region" {
  description = "Cloud Region."
  value       = airtelcloud_vm.this.region
}
