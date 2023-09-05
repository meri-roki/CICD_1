# Provision AKS Cluster

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  #name                = "aks-${var.product_name}-${var.environment}-${var.location_abbreviation}-01"
  name                = "aks-${var.product_name}-${var.location_abbreviation}-01"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  dns_prefix          = "aks-${var.product_name}-${var.environment}-${var.location_abbreviation}-01"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${azurerm_resource_group.main_rg.name}-aks-nrg"

  default_node_pool {
    name                 = "systempool"
    vm_size              = "Standard_E2ads_v5"
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    zones                = []
    enable_auto_scaling  = false
    max_count            = null
    min_count            = null
    node_count           = 3
    os_disk_size_gb      = 75
    os_disk_type         = "Ephemeral"
    max_pods             = 75
    type                 = "VirtualMachineScaleSets"
    vnet_subnet_id       = azurerm_subnet.snet_aks.id
    node_labels = {
      "nodepool-type" = "main"
      "environment"   = "${var.environment}"
      "nodepoolos"    = "linux"
      "app"           = "${var.product_name}"
    }
    tags = {
      "nodepool-type" = "main"
      "environment"   = "${var.environment}"
      "nodepoolos"    = "linux"
      "app"           = "${var.product_name}"
    }
  }

  # The upgrade channel for this Kubernetes Cluster
  # automatic_channel_upgrade = "none"

  # Identity (System Assigned or Service Principal)
  identity {
    type = "SystemAssigned"
  }

  # Add On Profiles
  http_application_routing_enabled = false

  # RBAC and Azure AD Integration Block
  role_based_access_control_enabled = true

  # Linux Profile
  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  # Network Profile
  network_profile {
    network_plugin     = "azure"
    network_policy     = "calico"
    load_balancer_sku  = "standard"
    service_cidr       = "10.119.0.0/16"
    dns_service_ip     = "10.119.0.10"
    docker_bridge_cidr = "172.19.0.1/16"

    # Loadbalancer Profile
    load_balancer_profile {
      #     outbound_ip_address_ids = [azurerm_public_ip.pip_aks.id]
      outbound_ip_address_ids = [azurerm_public_ip.pip_aks.id]
    }
  }

  tags = {
    Environment = "${var.environment}"
    Provisioned = "Terraform"
  }

  # lifecycle {
  #   ignore_changes = [
  #     # Ignore changes to tags, e.g. because a management agent
  #     # updates these based on some ruleset managed elsewhere.
  #     tags, default_node_pool.0.max_count, default_node_pool.0.min_count
  #   ]
  # }
}

# add the role to the identity the kubernetes cluster was assigned
resource "azurerm_role_assignment" "aks_cluster_to_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
}

# add the role to the identity the kubernetes cluster was assigned
resource "azurerm_role_assignment" "aks_cluster_to_aks_vnet" {
  scope                = azurerm_virtual_network.vnet_aks.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
}

# add the role to the identity the kubernetes cluster was assigned
resource "azurerm_role_assignment" "aks_cluster_to_public_ip" {
  scope                = azurerm_public_ip.pip_aks.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
}
