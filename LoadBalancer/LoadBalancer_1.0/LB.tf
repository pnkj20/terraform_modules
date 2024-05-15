

# Resource-1: Create Azure Standard Load Balancer
resource "azurerm_lb" "app_lb" {
  name                    = var.lb_name
  location                = var.location
  resource_group_name     = var.rg_name
  sku = var.lb_sku#"Standard"

  tags = var.tags
  frontend_ip_configuration {
    name                 = var.frontend_ip_name
    subnet_id = var.subnet_id
    private_ip_address_allocation = var.frontend_ip_allocation
    #private_ip_address_version = "IPv4"
    # private_ip_address = "10.1.11.241"
  }
}

# Resource-3: Create LB Backend Pool
resource "azurerm_lb_backend_address_pool" "lb_backend_address_pool" {
  name                = var.lb-backend_name #"app-backend"
  loadbalancer_id     = azurerm_lb.app_lb.id
}

# Resource-4: Create LB Probe
# resource "azurerm_lb_probe" "app_lb_probe" {
#   name                =  var.lb_probe_name#"tcp-probe"
#   protocol            = var.lb_probe_protocol#"Tcp"
#   port                = var.lb_probe_protocol_port #80
#   loadbalancer_id     = azurerm_lb.app_lb.id
  
# }

# Resource-5: Create LB Rule
# resource "azurerm_lb_rule" "lb_rule_app1" {
#   name                           = var.lb_rule_name#"app-app1-rule"
#   protocol                       = var.lb_rule_protocol#"Tcp"
#   frontend_port                  = var.lb_rule_frontend_protocol_port# 80
#   backend_port                   = var.lb_rule_backend_protocol_port#80
#   frontend_ip_configuration_name = azurerm_lb.app_lb.frontend_ip_configuration[0].name
 
#   probe_id                       = azurerm_lb_probe.app_lb_probe.id
#   loadbalancer_id                = azurerm_lb.app_lb.id
  
# }
