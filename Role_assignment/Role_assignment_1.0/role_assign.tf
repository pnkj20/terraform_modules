data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "bv_st_ra" {
  
  scope                = var.sa_id
  role_definition_name = "Storage Account Backup Contributor"
  principal_id         = var.bv_principal_id
}
