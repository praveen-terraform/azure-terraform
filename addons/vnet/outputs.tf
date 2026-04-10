output "vnet_id" {
  description = "ID of the VNet"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Name of the VNet"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_ids" {
  description = "Map of subnet IDs"
  value = {
    for k, v in azurerm_subnet.subnet : k => v.id
  }
}

output "nsg_ids" {
  description = "Map of NSG IDs"
  value = {
    for k, v in azurerm_network_security_group.nsg : k => v.id
  }
}