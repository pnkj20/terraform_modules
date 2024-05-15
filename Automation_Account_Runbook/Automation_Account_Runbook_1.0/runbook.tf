data "local_file" "script" {
  filename = var.script-path
}

resource "azurerm_automation_runbook" "runbook" {
  name                    = var.runbook-name
  location                = var.location
  resource_group_name     = var.rg-name
  automation_account_name = var.aa-name
  log_verbose             = "true"
  log_progress            = "true"
  runbook_type            = "PowerShell"

  content = data.local_file.script.content
}