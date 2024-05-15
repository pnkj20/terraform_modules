variable "lb_name" {
  description = "Name of Load Balancer"
}

variable "rg_name" {
  description = "Name of Resource group"
}

variable "subnet_id" {
  description = "ID of subnet, where you creating lb"
}


variable "frontend_ip_name" {
  description = "Name of frontend ip"
}

variable "frontend_ip_allocation" {
  description = "Value of private ip address allocation"
}

# variable "lb_probe_name" {
#   description = "Name of lb probe"
# }

variable "lb_sku" {
  description = "Name of lb sku"
}
# variable "lb_probe_protocol" {
#   description = "Value of lb prob protocol port"
# }

# variable "lb_probe_protocol_port" {
#   description = "Value of lb prob protocol port"
# }


# variable "lb_rule_name" {
#   description = "Name of lb rule"
# }

# variable "lb_rule_protocol" {
#   description = "Value of lb rule protocol port"
# }

# variable "lb_rule_frontend_protocol_port" {
#   description = "Value of lb rule frontend protocol port"
# }

# variable "lb_rule_backend_protocol_port" {
#   description = "Value of lb rule backend protocol port"
# }


variable "lb-backend_name" {
  description = "Name of app-backend"
}



variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}

variable "tags" {
  type        = map(any)
  description = "Default Tags"
  
}

