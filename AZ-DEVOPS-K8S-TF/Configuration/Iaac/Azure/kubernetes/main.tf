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
}

resource "azurerm_resource_group" "rg1" {
    name = var.resource_group
    location = var.location
}

resource "azurerm_kubernetes_cluster" "kbtf" {
    name                = "kbtfcluster"
    location            = var.location
    resource_group_name = azurerm_resource_group.rg1.name
    dns_prefix          = "kbtfcluster"

    linux_profile {
        admin_user = "ubuntu"
        
        ssh_key {
            #key_data = file(var.ssh_public_key)
            key_data = "c/my/dir/key.pem"
        }
    }

    default_node_pool {
        name = "default"
        node_count = 1
        vm_size = "Standard_DS1_v2"
    }

    service_principle {
        client_id = var.client_id
        client_secret = var.client_secret
    }

    tags = {
        environment = var.environment
    }
}

terraform {
    backend "azurerm" {
        #storage_account_name = ""
        #access_key = ""
        #key = ""
        #container = ""
    }
}