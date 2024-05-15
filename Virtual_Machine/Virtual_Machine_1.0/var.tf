variable "vm_name" {}
variable "computer_name" {}
variable "resource_group_name" {}
variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}

variable "tags" {
  type        = map(any)
  description = "Default Tags"
}
variable "vm-size" {}
variable "AdminLogin" {}
variable "password" {}
variable "vm_set_id" {
  default =   null
}

variable "vm_nic_id" {}
variable "vSKU" {}
variable "os_disk_name" {}
variable "os_disk_caching" {}
variable "os_disk_storage_account_type" {}
variable "os_disk_disk_size_gb" {
  type = number  
}

variable "autoscale_configuration" {
  description = "Minimum or Maximum capacity for autoscaling. Accepted values are for Minimum in the range 0 to 100 and for Maximum in the range 2 to 125"
  type = object({
    min_capacity = number
    max_capacity = optional(number)
  })
  default = null
}