data "azurerm_client_config" "current" {}

# Create a storage account for NSG Flow Logs
resource "azurerm_storage_account" "sa" {
  name                            = var.sa_name
  resource_group_name             = var.rg_name
  location                        = var.location
  account_tier                    = var.account_tier
  account_replication_type        = var.SA_Type
  min_tls_version                 = var.tls_version
  allow_nested_items_to_be_public =  var.allow_nested_items_to_be_public
  identity {
    type = "SystemAssigned"
  }

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]

  }

  lifecycle {

    ignore_changes = [customer_managed_key]

  }

  tags = var.tags

}