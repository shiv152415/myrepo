output "resource_group" {
    value = azurerm_resource_group.rg1
}

output "storage_account_name" {
    value = azurerm_storage_account.satf.name
}

output "storage_account_access_key" {
    value = azurerm_storage_account.satf.primary_access_key
}

output "storage_container_name" {
    value = azurerm_storage_container.sactf.name
}
