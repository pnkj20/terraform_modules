variable "aa_name" {}
variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}
variable "rg_name" {}
variable "sku_name" {
    default = "Basic"  
}
variable "tags" {}
