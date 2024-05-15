variable "rg_name" {
  description = "Name of Resource group"
}

variable "pep_name" {
  description = "Name of KV private endpoint"
}

variable "pe_connection_name" {
  description = "Name of private service connection"
}

variable "subnet_id" {
  description = "ID of subnet, where you creating PE"
}

variable "resource_id" {
    description = "Keyvault id"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}
variable "subresource_names" {}