resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name

  address_space = var.network_address_space
  dns_servers   = var.network_dns_addresses

  tags = var.tags

  lifecycle {
    ignore_changes = [ddos_protection_plan]
  }
}