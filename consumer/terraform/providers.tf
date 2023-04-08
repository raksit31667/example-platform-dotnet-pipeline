terraform {
  backend "azurerm" {
    resource_group_name  = "example-platform-azure-kubernetes"
    storage_account_name = "exampleplatformacastate"
    container_name       = "terraform-state"
    key                  = "${var.repository_name}.tfstate"
  }
}

provider "azurerm" {
  features {}
}
