resource "azurerm_managed_disk" "managed_data_disk" {
  name                 = var.disk_name
  resource_group_name = var.rg_name
  location            = var.location_name
  storage_account_type = var.SA_Type
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
  lifecycle {
        ignore_changes = [encryption_settings]
    }
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach_disk_to_VM" {
  managed_disk_id    = azurerm_managed_disk.managed_data_disk.id
  virtual_machine_id = var.vm_id
  lun                = var.lun
  caching            = "ReadWrite"
}