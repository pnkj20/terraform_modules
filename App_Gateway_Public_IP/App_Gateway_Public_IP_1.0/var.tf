variable "tags_name" {
  type = map
  description = "Default Tags"
}

variable "rg_name" {}
variable "pip_name" {}
variable "location_name" {
    default = "canadacentral"
}
