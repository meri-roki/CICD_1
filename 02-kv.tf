#data "azurerm_key_vault_secrets" "global_iac" {
#  key_vault_id = data.azurerm_key_vault.keyvault_iac.id
#}
#
#data "azurerm_key_vault_secret" "global_iac" {
#  for_each     = toset(data.azurerm_key_vault_secrets.global_iac.names)
#  name         = each.key
#  key_vault_id = data.azurerm_key_vault.keyvault_iac.id
#}
