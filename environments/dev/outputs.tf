output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "subnet_ids" {
  value = module.vnet.subnet_ids
}

output "vm_name" {
  value = module.vm.vm_name
}

output "vm_public_ip" {
  value = module.vm.public_ip_address
}

output "storage_account_name" {
  value = azurerm_storage_account.dev.name
}