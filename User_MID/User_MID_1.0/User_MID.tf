resource "azurerm_user_assigned_identity" "user_mid" {
  name                = var.MID_name
  location            = var.location_name
  resource_group_name = var.rg_name
  tags = var.tags_name
}