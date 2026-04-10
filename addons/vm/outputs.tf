output "vm_id" {
  description = "ID of the VM"
  value       = azurerm_linux_virtual_machine.linuxvm.id
}

output "vm_name" {
  description = "Name of the VM"
  value       = azurerm_linux_virtual_machine.linuxvm.name
}

output "public_ip_address" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.vm_public_ip.ip_address
}

output "nic_id" {
  description = "NIC ID"
  value       = azurerm_network_interface.vm_nic.id
}