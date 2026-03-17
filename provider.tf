terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "fda970a4-53ed-46be-bc79-6b0570f82c08"
  tenant_id       = "6fcf4470-ae53-44a3-ae92-445dc58c2b34"
}