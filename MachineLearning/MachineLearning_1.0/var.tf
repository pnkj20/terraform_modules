variable "ml_name" {
  description = "Name of Machine Learning workspace"
}

variable "ml_pep_name" {
  description = "Name of ml private endpoint"
}


variable "ml_connection_name" {
  description = "Name of private service connection"
}

variable "rg_name" {
  description = "Name of Resource group"
}

variable "subnet_id" {
  description = "ID of subnet, where you creating PE"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}

variable "tags" {
  type        = map(any)
  description = "Default Tags"
  
}

variable "storage_account_id" {
  description = "ID of storage_account"
}

variable "key_vault_id" {
  description = "ID of key_vault"
}

variable "application_insights_id" {
  description = "ID of application_insights"
}

variable "container_registry_id" {
  description = "ID of container_registry"
}