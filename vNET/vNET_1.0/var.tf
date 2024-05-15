variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}

variable "rg_name" {
  description = "Name of Resource group"
}

variable "tags" {
  type        = map(any)
  description = "Default Tags"
  
}

variable "vnet_name" {
  description = "Name of Virtual Network"
}

variable "network_address_space" {
  description = "The IP Address range to use for the VNET"
  type        = list(string)
}

variable "network_dns_addresses" {
  description = "The DNS Server addresses to use for the VNET"
}