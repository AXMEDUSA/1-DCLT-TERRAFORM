terraform {
  backend "azurerm" {
    resource_group_name  = "rg-fiap-tech-challange-fase-4"
    storage_account_name = "safiaptechchallangetf4"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}