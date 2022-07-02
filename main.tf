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
    name = "shiv"
    location = "West Europe"
}

resource "azurerm_virtual_network" "vnet1" {
    name = "vnet11"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_subnet" "subnet1" {
    name = "subnet1"
    resource_group_name = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "myip1" {
    name = "myip"
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name
    allocation_method = "Static"
}

resource "azurerm_network_interface" "mynic11" {
    name = "mynic111"
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name

    ip_configuration {
        name = "internal"
        subnet_id = azurerm_subnet.subnet1.id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_windows_virtual_machine" "myvm1" {
    name = "myvm"
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name
    size = "Standard_D2as_v5"
    admin_username = "shivani"
    admin_password = "Administrator@123"
    network_interface_ids = [azurerm_network_interface.mynic11.id,]

    os_disk {
        name = "osdisk1"
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    
    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2016-Datacenter"
        version   = "latest"
    }
}