resource "azurerm_network_watcher" "networkwatcher" {
  name     = "NetworkWatcher_canadacentral"
  location = var.location
  # Resource Group Name can only be "NetworkWatcherRG" as Policy looks for that name only
  resource_group_name = "NetworkWatcherRG"

}

resource "azurerm_network_watcher_flow_log" "flow_logs" {
  name                      = var.nw_flog_name
  resource_group_name       = "NetworkWatcherRG"
  network_security_group_id = var.nsg_id
  network_watcher_name      = azurerm_network_watcher.networkwatcher.name
  storage_account_id        = var.storage_account_id
  enabled                   = true
  version                   = "2"

  retention_policy {
    enabled = true
    days    = 7
  }

  traffic_analytics {
    enabled               = true
    interval_in_minutes   = 60
    workspace_id          = var.la_ws_id
    workspace_region      = var.location
    workspace_resource_id = var.la_ws_rs_id
  }
}
