
resource "azurerm_machine_learning_workspace" "mlworkspace" {
  name                    = var.ml_name
  location                = var.location
  resource_group_name     = var.rg_name
  application_insights_id = var.application_insights_id
  key_vault_id            = var.key_vault_id
  storage_account_id      = var.storage_account_id
  container_registry_id   = var.container_registry_id
  public_network_access_enabled = false

  identity {
    type = "SystemAssigned"
  }  
  tags = var.tags
}
