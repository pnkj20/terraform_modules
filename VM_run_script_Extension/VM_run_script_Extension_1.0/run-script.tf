resource "azurerm_virtual_machine_extension" "run-script" {
  name                 = var.extension-name
  virtual_machine_id   = var.vm-id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = var.type_handler_version

  settings = <<SETTINGS
 {
  "commandToExecute": "powershell -ExecutionPolicy Unrestricted -encodedCommand ${textencodebase64(file("${var.script-path}"), "UTF-16LE")}"
 }
SETTINGS
tags = var.tags
}