variable "administrator_login" {
  description = "Admin login username"
}

variable "administrator_login_password" {
  description = "Admin Login password"
}

variable "sql_server_name" {
  description = "SQL Server name"
}

variable "location" {
  default = "canadacentral"
}

variable "rg_name" {
  description = "Name of the Resource group in which App service plan will be built"
}

variable "minimum_tls_version" {
    description = "Minimum TLS version the SQL server supports. Valid values 1.0, 1.1, 1.2. Defaults to 1.2 (preferred)."
    default = "1.2"
}

variable "sql_server_version" {
  description = "The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
  default = "12.0"
}

variable "transparent_data_encryption_key_vault_key_id" {
  type        = string
  description = "The Key Vault Key ID to use for Transparent Data Encryption. Defaults to null."
  default     = null
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Should SQL server be publicly available? Defaults to false."
  default     = false
}

variable "azuread_administrator" {
  type = list(object({
    azuread_authentication_only = optional(bool, true)
    login_username              = optional(string, "OH-CCO_OPS_DBAs@ontariohealth.ca")
    object_id                   = optional(string, "a9f60c8d-d1ac-4785-ae49-df2e65eacdd9")
    tenant_id                   = optional(string, "4ef96c5c-d83f-466b-a478-816a5bb4af62")
  }))
  default = [{
    azuread_authentication_only = true
    login_username              = "OH-CCO_OPS_DBAs@ontariohealth.ca"
    object_id                   = "a9f60c8d-d1ac-4785-ae49-df2e65eacdd9"
    tenant_id                   = "4ef96c5c-d83f-466b-a478-816a5bb4af62"
  }]
}

variable "identity" {
  description = "Map with identity block information."
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = {
    type         = "SystemAssigned"
    identity_ids = []
  }
}

variable "firewall_rules" {
  type = map(object({
    start_ip_address = optional(string)
    end_ip_address   = optional(string)
  }))
  description = "Map of objects containing information on firewall rules to be created."
  default     = {}
}

variable "tags" {}