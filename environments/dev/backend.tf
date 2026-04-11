terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "backendsatfstate"
    container_name       = "tfstate"
    key                  = "devenv.terraform.tfstate"
  }
}
