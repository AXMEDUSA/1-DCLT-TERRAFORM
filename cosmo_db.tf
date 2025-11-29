resource "azurerm_cosmosdb_account" "cosmos" {
  name                = "cosmosdb-togglemaster"
  location            = "eastus2"
  resource_group_name = "rg-fiap-tech-challange"

  offer_type = "Standard"
  kind       = "GlobalDocumentDB"



  consistency_policy {
    consistency_level = "Session"
  }

  capabilities {
    name = "EnableTable"     
  }

  capabilities {
    name = "EnableServerless"
  }

  geo_location {
  location            = "eastus2"
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_table" "table" {
  name                = "togglemaster"
  resource_group_name = "rg-fiap-tech-challange"
  account_name        = azurerm_cosmosdb_account.cosmos.name
}
