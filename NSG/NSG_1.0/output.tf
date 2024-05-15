output "nsg_name" {
    value = azurerm_network_security_group.Create_NSG.name
}

output "nsg_id" {
    value = azurerm_network_security_group.Create_NSG.id
}
