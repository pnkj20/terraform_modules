resource "azurerm_automation_job_schedule" "link-schedule" {
  resource_group_name     = var.rg-name
  automation_account_name = var.aa-name
  schedule_name           = var.schedule_name
  runbook_name            = var.runbook_name
}