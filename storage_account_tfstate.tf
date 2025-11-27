
    resource "azurerm_storage_account" "tfstate" {
    name = "safiaptechchallangetf"
    resource_group_name = "rg-fiap-tech-challange"
    location = azurerm_resource_group.rg.location
    account_tier = "Standard"
    account_replication_type = "LRS"

    # allow_blob_public_access = false
    }

    resource "azurerm_storage_container" "tfstate" {
    name = "tfstate"
    storage_account_id = azurerm_storage_account.tfstate.id
    container_access_type = "private"
    }