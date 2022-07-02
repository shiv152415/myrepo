output "client_key" {
    value = azurerm_kubernetes_cluster.kbtf.kube.config.0.client_key
}

output "client_certificate" {
    value = azurerm_kubernetes_cluster.kbtf.kube.config.0.client_certificate
}

output "client_ca_certificate" {
    value = azurerm_kubernetes_cluster.kbtf.kube.config.0.client_ca_certificate
}

output "cluster_username" {
    value = azurerm_kubernetes_cluster.kbtf.kube.config.0.username
}

output "cluster_password" {
    value = azurerm_kubernetes_cluster.kbtf.kube.config.0.password
}