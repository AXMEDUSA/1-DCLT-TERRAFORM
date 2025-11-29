resource "azurerm_private_dns_zone_virtual_network_link" "postgresql" {
  name                  = "vnet-link-postgresql"
  resource_group_name   = "rg-fiap-tech-challange"
  private_dns_zone_name = azurerm_private_dns_zone.postgresql.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}
