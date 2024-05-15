resource "azurerm_public_ip" "public_ip" {
  name                = var.pip_name  
  resource_group_name = var.rg_name
  location            = var.location_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = var.tags_name
}