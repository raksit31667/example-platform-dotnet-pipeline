terraform {
  backend "azurerm" {
    resource_group_name  = "#{resourceGroupName}#"
    storage_account_name = "#{terraformStateStorageAccountName}#"
    container_name       = "terraform-state"
    key                  = "${var.repository_name}.tfstate"
  }
}

provider "azurerm" {
  features {}
}
