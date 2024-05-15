resource "azurerm_mssql_managed_instance" "sql_mi" {
  name                         = var.instance_name
  resource_group_name          = var.rg_name
  location                     = var.location
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
  license_type                 = var.license_type
  subnet_id                    = var.mi_sn_id
  sku_name                     = var.sku
  vcores                       = var.core
  storage_size_in_gb           = var.storage_size
  timezone_id                  = "Eastern Standard Time"
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}