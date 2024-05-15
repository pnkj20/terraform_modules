output "key-id" {
    value = azurerm_key_vault_key.kvkey.id
}

output "key_uri" {
  value = azurerm_key_vault_key.kvkey.resource_id
}