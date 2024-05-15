output "application_insights" {
  description = "The application insights resource."
  value       = azurerm_application_insights.ai
  }

output "application_insights_id" {
    description = "App insight ID"
    value = azurerm_application_insights.ai.id
}  

output "connection_string" {
  value = azurerm_application_insights.ai.connection_string
}