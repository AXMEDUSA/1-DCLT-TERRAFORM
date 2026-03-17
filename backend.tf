terraform {
  backend "azurerm" {
    resource_group_name  = "rg-fiap-tech-challange-fase-3"
    storage_account_name = "safiaptechchallangetf3"
    container_name       = "tfstate"
  }
}