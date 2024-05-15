resource "azurerm_application_gateway" "main" {
  name                = var.app_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location_name
  enable_http2        = var.enable_http2
  zones               = var.zones
  firewall_policy_id  = var.firewall_policy_id != null ? var.firewall_policy_id : null
  tags                = var.tags_name

  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    capacity = var.sku.capacity
  }

  # A list with a single user managed identity id to be assigned
  #---------------------------------------------------------------
  dynamic "identity" {
    for_each = var.identity_ids != null ? [1] : []
    content {
      type         = "UserAssigned"
      identity_ids = var.identity_ids
    }
  }

  gateway_ip_configuration {
    name      = var.gateway_ip_configuration_name
    subnet_id = var.AppGW_sn_id
  }

  frontend_port {
    name = "${var.frontend_port_name}-80"
    port = 80
  }

  frontend_port {
    name = "${var.frontend_port_name}-443"
    port = 443
  }

  frontend_ip_configuration {
    name                          = var.frontend_ip_configuration_name
    public_ip_address_id          = var.AppGW_pip_id
  }

  # Backend Address Pool Configuration (Required)
  dynamic "backend_address_pool" {
    for_each = var.backend_address_pools
    content {
      name         = backend_address_pool.value.name
      fqdns        = backend_address_pool.value.fqdns
      ip_addresses = backend_address_pool.value.ip_addresses
    }
  }

# SSL Certificate (.pfx) Configuration (Optional)
  dynamic "ssl_certificate" {
    for_each = var.ssl_certificates
    content {
      name                = ssl_certificate.value.name
      key_vault_secret_id = lookup(ssl_certificate.value, "key_vault_secret_id", null)
    }
  }
  
  # HTTP Listener Configuration (Required)
  dynamic "http_listener" {
    for_each = var.http_listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = var.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.ssl_certificate_name == null ? "${var.frontend_port_name}-80" : "${var.frontend_port_name}-443"
      host_name                      = lookup(http_listener.value, "host_name", null)
      host_names                     = lookup(http_listener.value, "host_names", null)
      protocol                       = http_listener.value.ssl_certificate_name == null ? "Http" : "Https"
      require_sni                    = http_listener.value.ssl_certificate_name != null ? http_listener.value.require_sni : null
      ssl_certificate_name           = http_listener.value.ssl_certificate_name
      firewall_policy_id             = http_listener.value.firewall_policy_id
    }
  }

 ssl_policy {
        policy_type = "Custom" #"Predefined"
        min_protocol_version = "TLSv1_2"
        cipher_suites = ["TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256","TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"]
    }
    
  # Backend HTTP Settings (Required)
  dynamic backend_http_settings {
        for_each = var.backend_http_settings
        content {
          name                                = backend_http_settings.value.name
          cookie_based_affinity               = lookup(backend_http_settings.value, "cookie_based_affinity", "Disabled")
          affinity_cookie_name                = lookup(backend_http_settings.value, "affinity_cookie_name", null)
          path                                = lookup(backend_http_settings.value, "path", "/")
          port                                = backend_http_settings.value.enable_https ? 443 : 80
          probe_name                          = lookup(backend_http_settings.value, "probe_name", null)
          protocol                            = backend_http_settings.value.enable_https ? "Https" : "Http"
          request_timeout                     = lookup(backend_http_settings.value, "request_timeout", 30)
          host_name                           = backend_http_settings.value.pick_host_name_from_backend_address == false ? lookup(backend_http_settings.value, "host_name") : null
          pick_host_name_from_backend_address = lookup(backend_http_settings.value, "pick_host_name_from_backend_address", false)
        }
      }

  # Request routing rules Configuration (Required)
  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules
    content {
      name                        = request_routing_rule.value.name
      rule_type                   = lookup(request_routing_rule.value, "rule_type", "Basic")
      http_listener_name          = request_routing_rule.value.http_listener_name
      backend_address_pool_name   = request_routing_rule.value.redirect_configuration_name == null ? request_routing_rule.value.backend_address_pool_name : null
      backend_http_settings_name  = request_routing_rule.value.redirect_configuration_name == null ? request_routing_rule.value.backend_http_settings_name : null
      redirect_configuration_name = lookup(request_routing_rule.value, "redirect_configuration_name", null)
      rewrite_rule_set_name       = lookup(request_routing_rule.value, "rewrite_rule_set_name", null)
      url_path_map_name           = lookup(request_routing_rule.value, "url_path_map_name", null)
      priority                    = request_routing_rule.value.priority
    }
  }

  # Health Probe (Optional)
  dynamic "probe" {
    for_each = var.health_probes
    content {
      name                                      = probe.value.name
      host                                      = lookup(probe.value, "host", "127.0.0.1")
      interval                                  = lookup(probe.value, "interval", 30)
      protocol                                  = probe.value.port == 443 ? "Https" : "Http"
      path                                      = lookup(probe.value, "path", "/")
      timeout                                   = lookup(probe.value, "timeout", 30)
      unhealthy_threshold                       = lookup(probe.value, "unhealthy_threshold", 3)
      port                                      = lookup(probe.value, "port", 443)
      pick_host_name_from_backend_http_settings = lookup(probe.value, "pick_host_name_from_backend_http_settings", false)
      minimum_servers                           = lookup(probe.value, "minimum_servers", 0)
    }
  }
}