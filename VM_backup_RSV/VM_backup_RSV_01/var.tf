variable "rsv_name" {}
variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}
variable "rg_name" {}
variable "tags" {
  type        = map(any)
  description = "Default Tags" 
}
variable "sku" {}
variable "sa_mode" {}