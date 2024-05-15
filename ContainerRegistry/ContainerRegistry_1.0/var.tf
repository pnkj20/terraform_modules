variable "cr_name" {
  description = "Name of cr"
}

variable "cr_pep_name" {
  description = "Name of cr private endpoint"
}

variable "sku_size" {
  description = "SKU of the Container registry"
}

variable "cr_connection_name" {
  description = "Name of private service connection"
}

variable "rg_name" {
  description = "Name of Resource group"
}

variable "subnet_id" {
  description = "ID of subnet, where you creating PE"
}
variable "user_assigned_identity" {
  description = "Name of user_assigned_identity"
}




variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}

variable "key_vault_key_id" {
  description = "Name of key_vault_key_id"
}
variable "tags" {
  type        = map(any)
  description = "Default Tags"
  
}