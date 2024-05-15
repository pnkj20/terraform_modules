variable "database_name" {}
variable "sql_server_id" {}

variable "location" {
  default = "canadacentral"
}

variable "rg_name" {
  description = "Name of the Resource group in which App service plan will be built"
}

variable "sku_name" {
    description = "The SKU for sql database, For example, GP_S_Gen5_2,HS_Gen4_1,BC_Gen5_2, ElasticPool, Basic,S0, P2 ,DW100c, DS100"
    default = "Basic"
}

variable "min_capacity" {
  description = "Minimal capacity that database will always have allocated, if not paused. This property is only settable for Serverless databases."
  default = null
  
}

variable "auto_pause_delay_in_minutes" {
  description = "Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled. This property is only settable for Serverless databases."
  default = "-1"
}

variable "storage_account_type" {
  description = "Specifies the storage account type used to store backups for this database. Possible values are Geo, GeoZone, Local and Zone. Defaults to Geo."
  default = "Geo"
}

variable "license_type" {
  description = "Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice."
  default = null
}

variable "collation" {
  default = null
}

variable "max_size_gb" {
  description = "The max size of the database in gigabytes."
  
  default = null
}

variable "create_mode" {
  default = "Default"
}

variable "creation_source_database_id" {
  default = null
}
variable "restore_point_in_time" {
  default = null
}
variable "long_term_retention_policy" {
  type = map(object({
    monthly_retention = optional(string) 
    week_of_year      = optional(number) 
    weekly_retention  = optional(string) 
    yearly_retention  = optional(string) 
    }))
}
    

variable "short_term_retention_policy" {
  type = map(object({
    backup_interval_in_hours = optional(number)
    retention_days           = optional(number, 35) 
  }))
}

variable "tags" {}