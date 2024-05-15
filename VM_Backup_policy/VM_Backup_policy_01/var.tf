variable "plolicy_name" {}
variable "rg_name" {}
variable "rsv_name" {}
variable "instant_restore_resource_group" {}
variable "instant_restore_retention_days" {
  type = number
}
variable "backup_frequency" {
    type = object({
      frequency = optional(string)
      time = optional(string)
    })
    default = {
      frequency = "Daily"
      time = "20:00"
    }
}

variable "retention_daily" {
    type = number
}

variable "weekly_retention" {
    type = object({
      number_of_weeks = optional(number)
      weekdays        = optional(list(string))
    })
    default = {
        number_of_weeks = 42
        weekdays = ["Sunday"]
    }
}

variable "monthly_retention" {
    type = object({
      number_of_months = optional(number)
      weekdays        = optional(list(string))
      weeks = optional(list(string))
    })
    default = {
        number_of_months = 12
        weekdays = ["Sunday"]
        weeks = ["Last"]
    }
}

variable "yearly_retention" {
    type = object({
      number_of_years = number
      weekdays         = optional(list(string))
      weeks            = optional(list(string))
      months           = optional(list(string))
    })
    default = {
        number_of_years = 7
        weekdays = ["Sunday"]
        weeks = ["Last"]
        months = ["January"]
    }
}