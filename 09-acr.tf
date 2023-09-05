# Provision AKS Cluster

resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    Environment = "${var.environment}"
    Provisioned = "Terraform"
  }
}
