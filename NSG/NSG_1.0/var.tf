variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}

variable "rg_name" {
  description = "Name of Resource group"
}

variable "tags" {
  type        = map(any)
  description = "Default Tags"
  
}

variable "nsg_name" {
  description = "Name of NSG"
}

variable "security_rule_configuration" {
  type = list(object({
    name                          = optional(string)
    priority                      = optional(number)
    direction                     = optional(string)
    access                        = optional(string)
    protocol                      = optional(string)
    source_port_range             = optional(string)
    source_port_ranges            = optional(list(string))
    destination_port_range        = optional(string)
    destination_port_ranges       = optional(list(string))
    source_address_prefix         = optional(string)
    source_address_prefixes       = optional(list(string))
    destination_address_prefix    = optional(string)
    destination_address_prefixes  = optional(list(string))
  }))
  default = []
}
