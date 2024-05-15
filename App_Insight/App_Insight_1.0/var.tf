variable "ai_name" {
  description = "Name of Application Insight"
}


variable "rg_name" {
  description = "Name of Resource group"
}


variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}

variable "tags" {}

variable "application_insights" {
  type = object({
    application_type                      = optional(string, "web")
    inherit_tags                          = optional(bool, false)
    workspace_resource_id                 = optional(string)
    daily_data_cap_in_gb                  = optional(number)
    daily_data_cap_notifications_disabled = optional(bool)
    retention_in_days                     = optional(number, 90)
    sampling_percentage                   = optional(number, 100)
    disable_ip_masking                    = optional(bool, false)
    local_authentication_disabled         = optional(bool, false)
    internet_ingestion_enabled            = optional(bool, true)
    internet_query_enabled                = optional(bool, true)
    force_customer_storage_for_profiler   = optional(bool, false)
  })
  default = {

  }
  description = <<DESCRIPTION

  The Application Insights settings to assign to the App.

  DESCRIPTION
}