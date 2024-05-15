# LB Private IP Address List
output "lb_private_ip_addresses" {
  description = "Load Balancer Public Address"
  value = [azurerm_lb.app_lb.private_ip_addresses]
}

# Load Balancer ID
output "lb_id" {
  description = "The Internal Load Balancer ID."
  value = azurerm_lb.app_lb.id 
}

# Load Balancer Frontend IP Configuration Block
output "lb_frontend_ip_configuration" {
  description = "LB frontend_ip_configuration Block"
  value = [azurerm_lb.app_lb.frontend_ip_configuration]
}