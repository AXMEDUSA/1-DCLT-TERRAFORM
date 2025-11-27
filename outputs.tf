output "resource_group" {
  value = azurerm_resource_group.rg.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "snet-public-1" {
  value = azurerm_subnet.public_1.id
}

output "snet-private-1" {
  value = azurerm_subnet.private_1.id
}