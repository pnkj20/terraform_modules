variable "sa_name" {
  description = "Name of Storage Account"
}

variable "rg_name" {
  description = "Name of Resource group"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}

variable "tags" {
  type        = map(any)
  description = "Default Tags"
}


variable "account_tier" {}
variable "SA_Type" {}
variable "tls_version" {}
variable "allow_nested_items_to_be_public" {}