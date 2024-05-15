resource "azurerm_virtual_machine_extension" "sql" {
  name                 = "SQLIaasExtension"
  virtual_machine_id   = var.vm-id
  publisher            = "Microsoft.SqlServer.Management"
  type                 = "SqlIaaSAgent"
  type_handler_version = var.exten-version

  auto_upgrade_minor_version = true
}