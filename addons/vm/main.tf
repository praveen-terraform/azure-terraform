resource "azurerm_public_ip" "vm_public_ip" {
  name                = "${var.name}-pubip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [var.zone]
  tags                = var.tags
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = var.vm_size
  admin_username        = var.admin_username
  patch_assessment_mode = "AutomaticByPlatform"

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }

  identity {
    type = "SystemAssigned"
  }

  secure_boot_enabled = var.enable_security_features
  vtpm_enabled        = var.enable_security_features

  network_interface_ids = [
    azurerm_network_interface.vm_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.os_disk_size
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = var.enable_security_features ? "22_04-lts-gen2" : "22_04-lts"
    version   = "latest"
  }

  
  zone                       = var.zone
  tags                       = var.tags

  lifecycle {
    ignore_changes  = [identity]
    prevent_destroy = true
  }
}