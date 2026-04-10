resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_cidr
  location            = var.location
  dns_servers         = var.dns_servers
  tags                = var.tags

  dynamic "ddos_protection_plan" {
    for_each = var.enable_ddos && var.ddos_protection_plan_id != null ? [1] : []
    content {
      enable = true
      id     = var.ddos_protection_plan_id
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.subnet_address_prefix

  default_outbound_access_enabled = each.value.default_outbound_access_enabled
  service_endpoints               = each.value.service_endpoints

  private_endpoint_network_policies             = each.value.private_endpoint_network_policies_enabled ? "Enabled" : "Disabled"
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled

  dynamic "delegation" {
    for_each = each.value.delegation != null ? [each.value.delegation] : []
    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }

  lifecycle {
    ignore_changes = [delegation]
    prevent_destroy = true
  }
}

locals {
  subnet_names_with_nsg = {
    for subnet_name, subnet in var.subnets :
    subnet_name => subnet
    if subnet_name != "GatewaySubnet"
  }
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = local.subnet_names_with_nsg
  name                = "${var.vnet_name}-${each.key}-nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_network_security_rule" "nsg_rules" {
  for_each = merge([
    for subnet_name, subnet in local.subnet_names_with_nsg : {
      for rule in subnet.rules :
      "${subnet_name}-${rule.name}" => {
        subnet_name = subnet_name
        rule        = rule
      }
    }
  ]...)

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg[each.value.subnet_name].name

  name                       = each.value.rule.name
  priority                   = each.value.rule.priority
  direction                  = each.value.rule.direction
  access                     = each.value.rule.access
  protocol                   = title(each.value.rule.protocol)
  source_port_range          = each.value.rule.source_port_range
  destination_port_range     = each.value.rule.destination_port_range
  source_address_prefix      = each.value.rule.source_address_prefix
  destination_address_prefix = try(each.value.rule.destination_address_prefix, "*")
  description                = try(each.value.rule.description, "")
}

resource "azurerm_subnet_network_security_group_association" "subnet_association" {
  for_each                  = local.subnet_names_with_nsg
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}