variable "vm-extension-name" {}
variable "virtual_machine_id" {}
variable "kv-name" {}
variable "encryption-key" {}
variable "handler_version" {
    default = "2.0"
}
variable "vm_encry_operation" {}
variable "vm_encry_kv_vault_id" {}
variable "vm_encry_kv_key_url" {}
variable "vm_encry_key_algorithm" {}
variable "vm_encry_volume_type" {}
variable "vm_encry_kv_vault_uri" {}