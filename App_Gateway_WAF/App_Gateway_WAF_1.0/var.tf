variable "waf_policy_name" {}
variable "rg_name" {}
variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}

variable "tags" {
  type        = map(any)
  description = "Default Tags"
  
}

variable "policy_enabled" {
  description = "Describes if the policy is in `enabled` state or `disabled` state. Defaults to `true`."
  type        = string
  default     = true
}

variable "policy_mode" {
  description = "Describes if it is in detection mode or prevention mode at the policy level. Valid values are `Detection` and `Prevention`. Defaults to `Prevention`."
  type        = string
  default     = "Prevention"
}

variable "policy_file_limit" {
  description = "Policy regarding the size limit of uploaded files. Value is in MB. Accepted values are in the range `1` to `4000`. Defaults to `100`."
  type        = number
  nullable    = false
  default     = 100
}

variable "policy_request_body_check_enabled" {
  description = "Describes if the Request Body Inspection is enabled. Defaults to `true`."
  type        = string
  default     = true
}

variable "policy_max_body_size" {
  description = "Policy regarding the maximum request body size. Value is in KB. Accepted values are in the range `8` to `2000`. Defaults to `128`."
  type        = number
  default     = 128
}

variable "managed_rule_set_configuration" {
  description = "Managed rule set configuration."
  type = list(object({
        type    = optional(string, "OWASP")
        version = optional(string, "3.2")
        rule_group_override_configuration = optional(list(object({
        rule_group_name = optional(string, null)
        rule = optional(list(object({
                id      = string
                enabled = optional(bool)
                action  = optional(string)
            })), [])
        })))
    }))
  default = []
}

variable  "custom_rules_configuration" {
  description           = "List of custome rules" 
        type = list(object({
            name      = optional(string)
            priority  = optional(number)
            rule_type = optional(string)
            action    = optional(string)
            match_conditions_configuration = optional(list(object({
            match_variable_configuration = optional(list(object({
                variable_name = optional(string)
                selector      = optional(string, null)
            })))
            match_values       = optional(list(string))
            operator           = optional(string)
            negation_condition = optional(string, null)
            transforms         = optional(list(string), null)
        }))) #match_conditions_configuration
    })) #custom_rules_configuration
  default = []
}

variable "exclusion_configuration" {
  type = list(object({
    match_variable          = optional(string)
    selector                = optional(string)
    selector_match_operator = optional(string)
    excluded_rule_set_configuration = optional(list(object({
      type    = optional(string, "OWASP")
      version = optional(string, "3.2")
      rule_group = optional(list(object({
        rule_group_name = optional(string)
        excluded_rules  = optional(list(string))
      })))
    })))
  }))
  default = []
}