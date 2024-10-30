variable "location" {
  default = "East US"
}

variable "resource_group_name" {
  default = "aks-resource-group"
}
variable "virtual_network_name"{
  default = "aks-virtual-network"
}
variable "aks_subnet_name"{
  default = "aks_subnet_name"
}

variable "aks_cluster_name" {
  default = "aks-cluster"
}

variable "node_pool_name" {
  default = "default"
}