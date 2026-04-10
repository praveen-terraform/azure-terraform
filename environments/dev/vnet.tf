module "vnet" {
  source = "../../addons/vnet"

  vnet_name                  = local.vnet_name
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  vnet_cidr                  = var.vnet_cidr
  dns_servers                = var.dns_servers
  enable_ddos                = var.enable_ddos
  ddos_protection_plan_id    = var.ddos_protection_plan_id
  tags                       = local.tags

  subnets = {
    vm-subnet = {
      subnet_address_prefix           = var.subnet_vm_cidr
      default_outbound_access_enabled = false
      service_endpoints               = ["Microsoft.Storage", "Microsoft.KeyVault"]

      rules = [
        {
          name                       = "Allow-SSH"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
          description                = "Allow SSH access"
        },
        {
          name                       = "Allow-HTTPS-Out"
          priority                   = 200
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
          description                = "Allow outbound HTTPS"
        }
      ]
    }

    app-subnet = {
      subnet_address_prefix           = var.subnet_app_cidr
      default_outbound_access_enabled = false
      service_endpoints               = ["Microsoft.Storage"]

      rules = [
        {
          name                       = "Allow-HTTPS-In"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
          description                = "Allow inbound HTTPS"
        }
      ]
    }
  }
}