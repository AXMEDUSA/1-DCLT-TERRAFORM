resource "azurerm_redis_cache" "redis" {
  name                = "redis-togglemaster-fase-4"
  location            = "eastus2"
  resource_group_name = "rg-fiap-tech-challange-fase-4"

  sku_name = "Basic"
  family   = "C"
  capacity = 0 # C0 = mais barato possível

  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"
}