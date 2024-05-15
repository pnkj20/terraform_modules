resource "azurerm_virtual_machine_extension" "vm-disk-encryption" {
  name                       = var.vm-extension-name
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "AzureDiskEncryption"
  type_handler_version       = var.handler_version
  auto_upgrade_minor_version = true

  settings = jsonencode({
    EncryptionOperation      = var.vm_encry_operation
    KeyVaultURL              = var.vm_encry_kv_vault_uri
    KeyVaultResourceId       = var.vm_encry_kv_vault_id
    KeyEncryptionKeyURL      = var.vm_encry_kv_key_url
    KekVaultResourceId       = var.vm_encry_kv_vault_id
    KeyEncryptionAlgorithm   = var.vm_encry_key_algorithm
    VolumeType               = var.vm_encry_volume_type 
  })
}