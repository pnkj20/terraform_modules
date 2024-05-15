resource "azurerm_recovery_services_vault" "backupvault" {
  name                = var.rsv_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = var.sku
  storage_mode_type   = var.sa_mode
  soft_delete_enabled = true

  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}
