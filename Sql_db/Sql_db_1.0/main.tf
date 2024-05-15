resource "azurerm_mssql_database" "db" {
 
  # Since sku_names now determine server type, we need to compute the type here.
  # Serverless will always have GP_S_xx, and we can therefore deduce this from splitting by underscore.
  # License type not allowed for serverless databases
  name                        = var.database_name
  server_id                   = var.sql_server_id
  sku_name                    = var.sku_name
  min_capacity                = var.min_capacity
  auto_pause_delay_in_minutes = var.auto_pause_delay_in_minutes
  storage_account_type        = var.storage_account_type
  license_type                = var.license_type
  collation                   = var.collation
  max_size_gb                 = var.max_size_gb
  create_mode                 = var.create_mode
  creation_source_database_id = var.creation_source_database_id
  
  restore_point_in_time = var.restore_point_in_time
  dynamic "long_term_retention_policy" {
    # Long term retention policy not allowed for serverless databases with auto-pause enabled.
    
    for_each = var.long_term_retention_policy
    content {
      monthly_retention = long_term_retention_policy.value.monthly_retention
      week_of_year      = long_term_retention_policy.value.week_of_year
      weekly_retention  = long_term_retention_policy.value.weekly_retention
      yearly_retention  = long_term_retention_policy.value.yearly_retention
    }
  }

  dynamic "short_term_retention_policy" {

    # Retention_days - (Required) Point In Time Restore configuration. Value has to be between 1 and 35.
    for_each = var.short_term_retention_policy
    content {
     retention_days           = short_term_retention_policy.value.retention_days
     backup_interval_in_hours = short_term_retention_policy.value.backup_interval_in_hours
    }
  }

  lifecycle {
   prevent_destroy = true
  }  
}