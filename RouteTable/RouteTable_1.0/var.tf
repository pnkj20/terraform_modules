variable "rt_name" {
  description = "Name of Route table"
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

variable "route_name" {}
variable "address_prefix" {}
variable "next_hop_type" {}
variable "next_hop_in_ip_address" {}
variable "route_subnet_id" {}