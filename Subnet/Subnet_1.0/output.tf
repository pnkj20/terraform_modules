output "subnet_cidrs_map" {
  description = "Map with names and CIDRs of the created subnets"
  value = {
    (azurerm_subnet.subnet.name) = azurerm_subnet.subnet.address_prefixes
  }
}

output "id" {
  description = "ID of the subnet"
  value = azurerm_subnet.subnet.id
  
}