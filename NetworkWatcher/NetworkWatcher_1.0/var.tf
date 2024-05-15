variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}

variable "nw_flog_name" {
  description = "Name of Network watcher flow logs"
}

variable "nsg_id" {
  description = "NSG ID"
}

variable "storage_account_id" {
  description = "SA ID"
}

variable "la_ws_id" {
  description = "Log Analytics workspace ID for NSG Flow Logs"
  default = "9b172827-fed7-478d-a047-2b13cedfb786"
}

variable "la_ws_rs_id" {
  description = "Log Analytics workspace resource ID for NSG Flow Logs"
  default = "/subscriptions/a09a08ae-025f-4942-8d55-6496729927ba/resourcegroups/rg-monitoring-prod-cco-001/providers/microsoft.operationalinsights/workspaces/la-prod-cco-l8ad1"
}
