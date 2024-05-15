resource "azurerm_key_vault_access_policy" "kv_access_policy" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  key_permissions = var.key-permissions
  secret_permissions = var.secret_permissions
  certificate_permissions = var.certificate_permissions
}