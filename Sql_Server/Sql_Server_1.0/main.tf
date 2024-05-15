resource "azurerm_mssql_server" "sqlsrv" {
  administrator_login                          = var.administrator_login
  administrator_login_password                 = var.administrator_login_password
  location                                     = var.location
  name                                         = var.sql_server_name
  resource_group_name                          = var.rg_name
  minimum_tls_version                          = var.minimum_tls_version
  version                                      = var.sql_server_version
  transparent_data_encryption_key_vault_key_id = var.transparent_data_encryption_key_vault_key_id != null ? var.transparent_data_encryption_key_vault_key_id : null

  public_network_access_enabled = var.public_network_access_enabled

  dynamic "azuread_administrator" {
    for_each = var.azuread_administrator[0].login_username != "" ? [1] : []
    # Only 1 or 0 of this block is supported. Always use index 0 of azuread_administrator block if supplied
    content {
      azuread_authentication_only = var.azuread_administrator[0].azuread_authentication_only
      login_username              = var.azuread_administrator[0].login_username
      object_id                   = var.azuread_administrator[0].object_id
      tenant_id                   = var.azuread_administrator[0].tenant_id
    }
  }

  dynamic "identity" {
    for_each = var.identity[*]
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }

  tags = var.tags
}

resource "azurerm_mssql_firewall_rule" "sql" {
  for_each         = var.firewall_rules
  name             = each.key
  server_id        = azurerm_mssql_server.sqlsrv.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}