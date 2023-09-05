resource "helm_release" "storage_class" {
  name  = "azure-custom-sc"
  chart = "./helm-charts/azure-custom-sc"

 # values = [
  #  "${file("./helm-charts/azure-custom-sc/values.yaml")}"
  #]

  # Azure File storage account NFS parameters
  set {
    name  = "azureFileStorageClass.location"
    value = azurerm_resource_group.main_rg.location
  }

  set {
    name  = "azureFileStorageClass.storageAccount"
    value = azurerm_storage_account.st_witron_premium_fs.name
  }

  set {
    name  = "azureFileStorageClass.resourceGroup"
    value = azurerm_resource_group.main_rg.name
  }
}

