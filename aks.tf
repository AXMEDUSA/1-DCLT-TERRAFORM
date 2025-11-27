resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-togglemaster"
  location            = "eastus2"
  resource_group_name = "rg-fiap-tech-challange"
  dns_prefix          = "togglemaster"

  sku_tier = "Free"

  default_node_pool {
    name       = "default"
    vm_size    = "Standard_D2s_v3"
    node_count = 1
    type       = "VirtualMachineScaleSets"

  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].upgrade_settings
    ]
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  tags = {
    env = "fiap-tech-challange"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "default_pool" {
  name                  = "togglemaster"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = "Standard_D2s_v3"
  auto_scaling_enabled  = true
  min_count             = 1
  max_count             = 2
  mode                  = "System"
  
  lifecycle {
    ignore_changes = [
      upgrade_settings
    ]
  }
}