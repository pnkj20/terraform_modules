output "disk_id" {
  value = azurerm_managed_disk.managed_data_disk.id
}

output "attatch_id" {
  value = azurerm_virtual_machine_data_disk_attachment.attach_disk_to_VM.id
}