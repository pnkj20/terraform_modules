resource "azurerm_backup_protected_vm" "vm_backup_protect" {
#  for_each = toset(var.vm-ids)
  resource_group_name = var.backup_rg_name
  recovery_vault_name = var.rsv_name
  backup_policy_id    = var.backup_policy_id
  source_vm_id        = var.vm-id
}