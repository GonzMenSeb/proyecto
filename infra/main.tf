# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.32.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "InfraTest" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_log_analytics_workspace" "InfraTest" {
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.InfraTest.location
  resource_group_name = azurerm_resource_group.InfraTest.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "InfraTest" {
  name                       = var.container_app_environment_name
  location                   = azurerm_resource_group.InfraTest.location
  resource_group_name        = azurerm_resource_group.InfraTest.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.InfraTest.id
}

resource "azurerm_container_app" "InfraTest" {
  name                         = var.container_app_name
  container_app_environment_id = azurerm_container_app_environment.InfraTest.id
  resource_group_name          = azurerm_resource_group.InfraTest.name
  revision_mode                = "Single"

  template {
    container {
      name   = "examplecontainerapp"
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}
