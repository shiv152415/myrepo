terraform {
  required_providers {
    azurerm = {
        source  = "hashicorp/azurerm"
        version = "~> 2.65"
    }
  }

  required_version = ">= 0.14.9"
}
provider "azurerm" {
    features {}
    clent_id = var.client_id
    client_secret = var.client_secret
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
}

resource "azurerm_resource_group" "rg1" {
    name = var.resource_group
    location = var.location 
}

resource "azurerm_storage_account" "satf" {
    name = "mystorageaccount87654"
    location = var.location
    resource_group_name = var.resource_group
    access_tier = "Standard"
    account_replication_type = "LRS"

    tags {
        environment = "Dev"
    }
}

resource "azurerm_storage_container" "sactf" {
    name = "devsactf"
    storage_account_name = azurerm_storage_account.satf.name
}
