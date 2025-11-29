
resource "azurerm_postgresql_flexible_server" "db" {
  for_each = local.databases

  name                = each.value.name
  resource_group_name = "rg-fiap-tech-challange"
  location            = "Central US"
  version             = "16"

  administrator_login    = local.db_admin_username
  administrator_password = local.db_admin_password
  public_network_access_enabled = false


  delegated_subnet_id           = azurerm_subnet.private_2.id
  private_dns_zone_id           = azurerm_private_dns_zone.postgresql.id



  sku_name     = each.value.sku_name
  storage_mb   = 32768
  storage_tier = "P4"

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  zone                         = "1"

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.postgresql
  ]
}
