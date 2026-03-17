# Storage Account (necessária para Queue)
resource "azurerm_storage_account" "sa-togglemaster" {
  name                     = "satogglemasterf3"
  resource_group_name      = "rg-fiap-tech-challange-fase-3"
  location                 = "eastus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Fila de mensagens (tipo SQS)
resource "azurerm_storage_queue" "queue" {
  name               = "fila-togglemaster"
  storage_account_id = azurerm_storage_account.sa-togglemaster.id
}