resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-togglemaster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "togglemaster"

  sku_tier = "Free"

  default_node_pool {
    name                       = "default"
    vm_size                    = "Standard_D2s_v3"
    node_count                 = 1
    type                       = "VirtualMachineScaleSets"
    # MODIFICADO: Conectar AKS à vnet-fiap-tech
    vnet_subnet_id             = azurerm_subnet.private_1.id
    # ADICIONADO: Necessário para rotacionar nós ao alterar vnet_subnet_id
    temporary_name_for_rotation = "temp"
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
    # # MODIFICADO: Mudado de 'kubenet' para 'azure' para melhor integração com VNet
    network_plugin    = "azure"
    # # ADICIONADO: Policy de segurança para rede
    network_policy    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
    # # ADICIONADO: CIDR reservado para serviços do Kubernetes
    service_cidr      = "10.1.0.0/16"
    # # ADICIONADO: IP do DNS do Kubernetes
    dns_service_ip    = "10.1.0.10"
  }

  tags = {
    env = "fiap-tech-challange"
  }

  # ADICIONADO: Garante que a subnet existe antes de criar o AKS
  depends_on = [
    azurerm_subnet.private_1
  ]
}

resource "azurerm_kubernetes_cluster_node_pool" "default_pool" {
  name                  = "togglemaster"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = "Standard_D2s_v3"
  # ADICIONADO: Conectar node pool à vnet-fiap-tech
  vnet_subnet_id        = azurerm_subnet.private_1.id
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