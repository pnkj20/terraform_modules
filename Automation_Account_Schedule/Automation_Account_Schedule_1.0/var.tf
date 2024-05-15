variable "schedule-name" {}
variable "rg-name" {}
variable "aa-name" {}
variable "frequency" {}
variable "interval" {
  type = number
}
variable "start_time" {}
variable "week_days" {
  type = list(string)
}