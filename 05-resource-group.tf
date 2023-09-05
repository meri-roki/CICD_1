# Terraform Resource to Create Azure Resource Group with Input Variables defined in variables.tf
resource "azurerm_resource_group" "main_rg" {
  name     = "rg-${var.product_name}-${var.environment}-01"
  location = var.location


  tags = {
    Environment = "${var.environment}"
    Provisioned = "Terraform"
  }
}

resource "azurerm_public_ip" "pip_aks" {
  name                = "myAKSPublicIP"
  location            = var.location
  resource_group_name = "Test_Kubernates_group"
  allocation_method   = "Static"
  sku                 = "Standard"
}
