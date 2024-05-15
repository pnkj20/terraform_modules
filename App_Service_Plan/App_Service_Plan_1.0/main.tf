### NOTE: "azurerm_app_service_plan" resource has been deprecated in version 3.0 of the AzureRM provider 
# and will be removed in version 4.0. Please use "azurerm_service_plan" resource instead.

resource "azurerm_service_plan" "webappplan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.rg_name
  sku_name = var.sku_name
  os_type = var.os_type

  tags = var.tags
}