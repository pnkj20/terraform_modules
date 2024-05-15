output "mid" {
  value = azurerm_user_assigned_identity.user_mid.id
}

output "client_id" {
  value = azurerm_user_assigned_identity.user_mid.client_id
}

output "principal_id" {
  value = azurerm_user_assigned_identity.user_mid.principal_id
}