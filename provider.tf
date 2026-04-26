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
  subscription_id = "ae352d8a-54b2-4e9c-adc6-3690dba03c13"
  tenant_id       = "3d8de9da-a6fd-4398-be01-329fdfbb01f4"
}