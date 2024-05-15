output "iam_id" {
  description = "The ID of the role assignment"
  value = azurerm_role_assignment.iam_role_assign.id
}