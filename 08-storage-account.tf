# Storage Accounts

resource "azurerm_storage_account" "st_witron_premium_fs" {
  #name                             = "st${var.product_name}01${var.environment}"
  name                             = "st${var.product_name}"
  location                         = azurerm_resource_group.main_rg.location
  resource_group_name              = azurerm_resource_group.main_rg.name
  account_tier                     = "Premium"
  account_kind                     = "FileStorage"
  account_replication_type         = "LRS"
  access_tier                      = "Hot"
  enable_https_traffic_only        = false
  min_tls_version                  = "TLS1_2"
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.snet_aks.id]
  }

  share_properties {
    retention_policy {
      days = 30
    }
  }

  tags = {
    Environment = "${var.environment}"
    Provisioned = "Terraform"
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to smb, because AKS updates these elsewhere.
      share_properties.0.smb
    ]
  }
}

# add the role to the identity the kubernetes cluster was assigned
resource "azurerm_role_assignment" "aks_cluster_to_storage_witron_fs" {
  scope                = azurerm_storage_account.st_witron_premium_fs.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
}
