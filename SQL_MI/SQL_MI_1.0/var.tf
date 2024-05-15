variable "instance_name" {}
variable "rg_name" {}
variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}
variable "admin_login" {}
variable "admin_password" {}
variable "license_type" {}
variable "mi_sn_id" {}
variable "sku" {}
variable "core" {
    type = number  
}
variable "storage_size" {
    type = number  
}
variable "tags" {
  type        = map(any)
  description = "Default Tags"
  
}
