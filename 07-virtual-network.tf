# Create Virtual Network for AKS
resource "azurerm_virtual_network" "vnet_aks" {
  name                = "vnet-${var.environment}-${var.location_abbreviation}-01"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  address_space       = ["10.160.244.0/22"]

  tags = {
    Environment = "${var.environment}"
    Provisioned = "Terraform"
  }
}

# Create a Default Subnet For AKS
resource "azurerm_subnet" "snet_aks" {
  name                 = "snet-${var.environment}-${var.location_abbreviation}-01"
  virtual_network_name = azurerm_virtual_network.vnet_aks.name
  resource_group_name  = azurerm_resource_group.main_rg.name
  address_prefixes     = ["10.160.244.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage", "Microsoft.KeyVault"]
}

