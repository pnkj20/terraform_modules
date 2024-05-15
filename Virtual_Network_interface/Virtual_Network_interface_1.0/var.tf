variable "nic_name" {}
variable "location_name" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}

variable "rg_name" {}
variable "subnet_id" {}
variable "private_IP" {}
variable "tags" {
  type        = map(any)
  description = "Default Tags"
}