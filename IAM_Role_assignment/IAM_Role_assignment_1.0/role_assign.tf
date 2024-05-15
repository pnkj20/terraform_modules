data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "iam_role_assign" {
  
  scope                = var.scope_id
  role_definition_name = var.role_definition_name
  principal_id         = var.principal_id
}
