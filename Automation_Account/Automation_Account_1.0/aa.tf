resource "azurerm_automation_account" "automationaccount" {
  name                = var.aa_name
  location            = var.location
  resource_group_name = var.rg_name
  sku_name            = var.sku_name
  tags = var.tags
  identity  {
    type = "SystemAssigned"
  }
}	