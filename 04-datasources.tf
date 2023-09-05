# Documentation Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_service_versions
# Datasource to get Latest Azure AKS latest Version
data "azurerm_kubernetes_service_versions" "current" {
  location = azurerm_resource_group.main_rg.location
  version_prefix  = "1.27"
  include_preview = false
}
#
#data "azurerm_key_vault" "keyvault_iac" {
#  name                = var.keyvault_name
#  resource_group_name = var.keyvault_rg
#}
