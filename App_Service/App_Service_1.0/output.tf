output "resource_id" {
  description = "This is the full output for the resource ID"
  sensitive   = true
  value       = var.os_type == "Windows" ? azurerm_windows_web_app.windows_webapp[0].id : azurerm_linux_web_app.linux_webapp[0].id
}

output "resource_uri" {
  description = "The default hostname of the resource."
  value       = var.os_type == "Windows" ? azurerm_windows_web_app.windows_webapp[0].default_hostname : azurerm_linux_web_app.linux_webapp[0].default_hostname
}