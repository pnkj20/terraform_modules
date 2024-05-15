#create route table
resource "azurerm_route_table" "rt" {
  name                = var.rt_name
  location            = var.location
  resource_group_name = var.rg_name
  disable_bgp_route_propagation = true

  tags = var.tags
}

#create route
resource "azurerm_route" "route" {
  name                   = var.route_name
  resource_group_name    = var.rg_name
  route_table_name       = var.rt_name
  address_prefix         = var.address_prefix
  next_hop_type          = var.next_hop_type
  next_hop_in_ip_address = var.next_hop_in_ip_address
  depends_on = [azurerm_route_table.rt]
}

#associate 
resource "azurerm_subnet_route_table_association" "rt_associate" {
  subnet_id      = var.route_subnet_id
  route_table_id = azurerm_route_table.rt.id
  depends_on = [azurerm_route_table.rt,azurerm_route.route]
}