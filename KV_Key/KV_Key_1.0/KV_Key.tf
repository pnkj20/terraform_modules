resource "azurerm_key_vault_key" "kvkey" {
  name            = var.kv_key_name
  expiration_date = var.expiration_date
  key_vault_id    = var.kv_id
  key_type        = "RSA"
  key_size        = 3072
  key_opts        = ["sign", "verify", "wrapKey", "unwrapKey", "encrypt", "decrypt"]
}
