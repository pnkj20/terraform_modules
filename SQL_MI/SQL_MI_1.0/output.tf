output "sql_mi_id" {
    value = azurerm_mssql_managed_instance.sql_mi.id  
}

output "sql_mi_fqdn" {
  value = azurerm_mssql_managed_instance.sql_mi.fqdn
}

output "sql_mi_dns_zone" {
  value = azurerm_mssql_managed_instance.sql_mi.dns_zone
}