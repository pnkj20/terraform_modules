variable "avail_vm_set_name" {}
variable "rg_name" {}
variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}
variable "tags" {
  type        = map(any)
  description = "Default Tags"
}