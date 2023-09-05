# Define Input Variables
# 1. Azure Location (CentralUS)
# 2. Azure Resource Group Name 
# 3. Azure AKS Environment Name (Dev, QA, Prod)

# Azure Location
variable "location" {
  type        = string
  description = "Azure Region where all these resources will be provisioned"
  # Germany West Central
  default = "westeurope"
}

# Azure Resource Group Name
variable "location_abbreviation" {
  type        = string
  description = "Azure Region abbreviation name where all these resources will be provisioned"
  default     = "weu"
}

# Azure Resource Group Name
variable "product_name" {
  type        = string
  description = "This variable defines the product name that we deploy here"
  default     = "testkubernetesgroup"
}

# Azure Project Environment Name
variable "environment" {
  type        = string
  description = "This variable defines the Environment"
  default     = "dev"
}

# Azure Keyvault Resource Group that Azure Keyvault exists for terraform sensitive data
variable "keyvault_rg" {
  type        = string
  description = "This variable defines the Keyvault Name"
  default     = "Test-Kubernates-group"
}

# Azure Keyvault Name for terraform sensitive data
variable "keyvault_name" {
  type        = string
  description = "This variable defines the Keyvault Name"
  default     = "Test-Kubernates-group"
}

# Azure Container Registry Name
variable "container_registry_name" {
  type        = string
  description = "This variable defines the Container Registry Name"
  default     = "acrberryonmars01"
}

# Azure ssh_public_key
variable "ssh_public_key" {
  #  type = string
  description = "This variable ssh_public_key"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCthsN1wQlZxMpOaPqLOWeh35BclZOLLj33DMLsNbCQFkBAXIFxweyWOvBpPg3Ki57cZn0ZFglErkBudTchJ3vFwAGl9OTNvhObQO4nCC2PKybs4BsUb+uL4DjuUKJBbOc2jNsNFHrfZumC/zK4ApaFuz1GSREekehLp6y7xQiNxguycf2rbiu0UNIHSprZEegAlOxR6QIBN9J65UqcUTVK6F+O+Ocwt39A486iGchNZ4V5RTf8K144isBFssM0eRtKR8xC7ikcHgrNrut0m8cHmsjibsOBaZJ7Wuzt7kNuDpQruuI6VT8/YgPf1BeACXVKN4rrSf+kQeOUGWlyIXdP1WY307xwkus2XOiy0uLOB93ASdrj7sI6ucMk/eGpUfxVVehBm0/gSxKUbddFg1/v4gHwL9AyFefSDbu3pAwjih+fQ6U8n1xOnON5+ND4f9NtjTZVU8x5HuxHI+2FH6glIpK7ugXHn0w/zfvIV3MD0P6LprBpaAexDgYyRa+pZHk= root@meha"
}

