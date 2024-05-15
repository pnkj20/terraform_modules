resource "azurerm_automation_schedule" "schedule" {
  name                    = var.schedule-name
  resource_group_name     = var.rg-name
  automation_account_name = var.aa-name
  frequency               = var.frequency
  interval                = var.interval
  timezone                = "America/Toronto"
  start_time              = var.start_time
  week_days               = var.week_days
}