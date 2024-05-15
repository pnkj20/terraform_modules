resource "azurerm_availability_set" "vm_availability_set" {
  name                = var.avail_vm_set_name
  resource_group_name = var.rg_name
  location            = var.location
  tags                = var.tags
}