variable "kv_name" {
  description = "Name of KV"
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