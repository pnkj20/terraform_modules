variable "subnet_name" {
  description = "Name of Subnet"
}

variable "rg_name" {
  description = "Name of Resource group"
}

variable "vnet_name" {
  description = "Name of Virtual Network"
}

variable "address_prefixes" {
  description = "The IP Address range to use for the VNET"
  type        = list(string)
}

variable "private_endpoint_network_policies_enabled" {
  description = "Enable or disable network policies for the Private Endpoint on the subnet."
  type        = bool
  default     = null
}

variable "service_endpoints" {
  type = list(string)
  default = []
}

variable "enable_delegation" {
  type    = bool
  default = false
}

variable "subnet_delegation" {
  type = object({
    name    = string
    actions = list(string)
  })

  default = {
    name    = "Microsoft.ContainerInstance/containerGroups"
    actions = [
      "Microsoft.Network/virtualNetworks/subnets/join/action",
      "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
      "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
    ]
  }
}