module "vm" {
  source = "../../addons/vm"

  name                     = local.vm_name
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  subnet_id                = module.vnet.subnet_ids["vm-subnet"]
  vm_size                  = var.vm_size
  admin_username           = var.admin_username
  public_key_path          = var.public_key_path
  os_disk_size             = var.os_disk_size
  enable_security_features = var.enable_security_features
  zone                     = var.availability_zone
  tags                     = local.tags
}

resource "random_string" "storage_suffix" {
  length  = 5
  upper   = false
  special = false
  numeric = true
}

resource "azurerm_storage_account" "dev" {
  name                     = "st${local.prefix_kebab}${local.hash_suffix}${random_string.storage_suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = local.tags

  lifecycle {
    prevent_destroy = true
  }
}