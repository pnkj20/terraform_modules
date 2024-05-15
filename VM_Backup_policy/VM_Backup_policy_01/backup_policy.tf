resource "azurerm_backup_policy_vm" "vm_backup_policy" {
  name                = var.plolicy_name
  resource_group_name = var.rg_name
  recovery_vault_name = var.rsv_name
  timezone = "Eastern Standard Time"
  
  instant_restore_resource_group { 
    prefix = var.instant_restore_resource_group
  }
  instant_restore_retention_days = var.instant_restore_retention_days

  backup {
    frequency = var.backup_frequency.frequency
    time      = var.backup_frequency.time
  }

retention_daily {
    count = var.retention_daily
  }

  retention_weekly {
    count    = var.weekly_retention.number_of_weeks
    weekdays = var.weekly_retention.weekdays
  }

  retention_monthly {
    count    = var.monthly_retention.number_of_months
    weekdays = var.monthly_retention.weekdays
    weeks    = var.monthly_retention.weeks
  }

    retention_yearly {
        count           = var.yearly_retention.number_of_years
        weekdays        = var.yearly_retention.weekdays
        weeks           = var.yearly_retention.weeks
        months          = var.yearly_retention.months
    }
}