
resource "azurerm_container_registry" "ctreg" {
  name                = var.cr_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = var.sku_size
  admin_enabled       = false
  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.acr_uai.id
    ]
  }

  network_rule_set {
    default_action = "Deny"
  }
  public_network_access_enabled = false


  encryption {
    enabled            = true
    key_vault_key_id   = var.key_vault_key_id #  data.azurerm_key_vault_key.example.id
    identity_client_id = azurerm_user_assigned_identity.acr_uai.client_id
    
  }

    tags = var.tags

}


#--User Assigned Identity
resource "azurerm_user_assigned_identity" "acr_uai" {
  resource_group_name = var.rg_name
  location            = var.location
  name = var.user_assigned_identity
}


# ============ Private Endpoint for Container Registry ==========================

resource "azurerm_private_endpoint" "crpep" {
  name                = var.cr_pep_name
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  tags = var.tags
  private_service_connection {
    name                           = var.cr_connection_name
    private_connection_resource_id = azurerm_container_registry.ctreg.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }
}