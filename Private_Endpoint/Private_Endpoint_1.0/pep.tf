resource "azurerm_private_endpoint" "pep" {
  name                = var.pep_name
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = var.pe_connection_name
    private_connection_resource_id = var.resource_id
    subresource_names              = [var.subresource_names]
    is_manual_connection           = false
  }
}