resource "azurerm_resource_group" "aks_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "aks_vnet" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/8"]
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
}

# Subnet
resource "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_subnet_name
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "k8s"
  
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_d4pds_v5"
    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }
}




