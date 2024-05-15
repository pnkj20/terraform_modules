output "waf_policy_id" {
  description = "Waf Policy ID"
  value       = azurerm_web_application_firewall_policy.waf_policy.id
}

output "path_based_rule_ids" {
  description = "A list of URL Path Map Path Rule IDs from an azurerm_application_gateway."
  value       = azurerm_web_application_firewall_policy.waf_policy.path_based_rule_ids
}