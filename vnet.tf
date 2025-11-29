resource "azurerm_virtual_network" "vnet" {
name = "vnet-fiap-tech"
resource_group_name = "rg-fiap-tech-challange"
location = azurerm_resource_group.rg.location
address_space = ["10.0.0.0/16"]
}


# Subnets Públicas
resource "azurerm_subnet" "public_1" {
name = "snet-public-1"
resource_group_name = "rg-fiap-tech-challange"
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes = ["10.0.1.0/24"]
}


# resource "azurerm_subnet" "public_2" {
# name = "snet-public-2"
# resource_group_name = "rg-fiap-tech-challange"
# virtual_network_name = azurerm_virtual_network.vnet.name
# address_prefixes = ["10.0.2.0/24"]
# }


# Subnets Privadas
resource "azurerm_subnet" "private_1" {
name = "snet-private-1"
resource_group_name = "rg-fiap-tech-challange"
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes = ["10.0.3.0/24"]
}


resource "azurerm_subnet" "private_2" {
name = "snet-private-2"
resource_group_name = "rg-fiap-tech-challange"
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes = ["10.0.4.0/24"]
  delegation {
    name = "fs-delegation"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}