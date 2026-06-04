output "vm_id" {
  description = "VM ID"
  value       = airtelcloud_vm.this.id
}

output "vm_status" {
  description = "VM status"
  value       = airtelcloud_vm.this.status
}

output "private_ip" {
  description = "VM private IP"
  value       = airtelcloud_vm.this.private_ip
}

output "public_ip" {
  description = "VM public IP"
  value       = airtelcloud_vm.this.public_ip
}

output "vm_name" {
  description = "VM name"
  value       = airtelcloud_vm.this.instance_name
}

output "vm" {
  description = "Complete VM object"
  value = {
    id         = airtelcloud_vm.this.id
    name       = airtelcloud_vm.this.instance_name
    status     = airtelcloud_vm.this.status
    private_ip = airtelcloud_vm.this.private_ip
    public_ip  = airtelcloud_vm.this.public_ip
  }
}
