resource "azurerm_application_insights" "ai" {
  
  application_type                      = var.application_insights.application_type
  location                              = var.location
  name                                  = var.ai_name
  resource_group_name                   = var.rg_name
  daily_data_cap_in_gb                  = var.application_insights.daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = var.application_insights.daily_data_cap_notifications_disabled
  disable_ip_masking                    = var.application_insights.disable_ip_masking
  force_customer_storage_for_profiler   = var.application_insights.force_customer_storage_for_profiler
  internet_ingestion_enabled            = var.application_insights.internet_ingestion_enabled
  internet_query_enabled                = var.application_insights.internet_query_enabled
  local_authentication_disabled         = var.application_insights.local_authentication_disabled
  retention_in_days                     = var.application_insights.retention_in_days
  sampling_percentage                   = var.application_insights.sampling_percentage
  tags                                  = var.tags
  workspace_id                          = var.application_insights.workspace_resource_id
}