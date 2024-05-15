variable "disk_name" {}
variable "rg_name" {}
variable "disk_size_gb" {
    type = number  
}
variable "location_name" {
    default = "canadacentral"  
}
variable "SA_Type" {}
variable "vm_id" {}
variable "lun" {
    type = number  
}
