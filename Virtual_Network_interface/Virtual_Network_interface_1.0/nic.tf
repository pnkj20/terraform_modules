resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location_name
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address            = var.private_IP
    private_ip_address_allocation = "Static"
  }

  tags = var.tags
}