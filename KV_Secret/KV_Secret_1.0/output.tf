output "secret_id" {
    value = azurerm_key_vault_secret.kv_secret.id  
}

output "secret_resorce_id" {
  value = azurerm_key_vault_secret.kv_secret.resource_id
}

output "version" {
  value = azurerm_key_vault_secret.kv_secret.version
}

output "resource_versionless_id" {
  value = azurerm_key_vault_secret.kv_secret.resource_versionless_id
}