data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

locals {
  allow_list_ip      = var.allow_list_ip
  #white_list_ip      = ["0.0.0.0"]
  registration_token = azurerm_virtual_desktop_host_pool_registration_info.registrationinfo.token
}


resource "azurerm_resource_group" "lob_rg" {
  name     = "rg-${var.projectName}-${var.lob_name}-${var.commonIdentifier}-${var.environment_number}"
  location = var.location
  
  tags = var.tags
}

resource "azurerm_application_security_group" "lob_asg" {
  name                = "asg-${var.projectName}-${var.commonIdentifier}-${var.lob_name}-${var.environment_number}"
  location            = var.location
  resource_group_name = azurerm_resource_group.lob_rg.name
}

#---------
resource "azurerm_network_interface" "avd_vm_nic" {
  count               = var.rdsh_count
  name                = "nic-0${count.index + 1}-${var.projectName}-${var.commonIdentifier}-${var.lob_name}-${var.environment_number}"
  resource_group_name = azurerm_resource_group.lob_rg.name
  location            = azurerm_resource_group.lob_rg.location

  ip_configuration {
    name                          = "nic${count.index + 1}_config"
    subnet_id                     = var.avd_subnet_id
    private_ip_address_allocation = "Dynamic" #"Static" #
  }

  depends_on = [
    azurerm_resource_group.lob_rg
  ]
}

resource "azurerm_windows_virtual_machine" "avd_vm" {
  count                      = var.rdsh_count
  name                       = upper("OH-${var.env}-${var.vm_name}-${count.index + 1}")
  computer_name              = upper("OH-${var.env}-${var.vm_name}-${count.index + 1}")
  resource_group_name        = azurerm_resource_group.lob_rg.name
  location                   = azurerm_resource_group.lob_rg.location
  size                       = var.vm_size
  network_interface_ids      = ["${azurerm_network_interface.avd_vm_nic.*.id[count.index]}"]
  provision_vm_agent         = true
  admin_username             = var.local_admin_username
  admin_password             = var.avd_local_password
  encryption_at_host_enabled = false 
  license_type          = "Windows_Client"
  secure_boot_enabled   = false
  vtpm_enabled          = false

  patch_mode = "Manual"  
  enable_automatic_updates = false

  boot_diagnostics {}

  os_disk {
    name                 = "disk-0${count.index + 1}-${var.projectName}-${var.lob_name}-${var.commonIdentifier}-${var.environment_number}"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }


  //source_image_id = data.azurerm_shared_image.avd.id
  source_image_id = "/subscriptions/${var.avdshared_subscription_id}/resourceGroups/${var.image_rg}/providers/Microsoft.Compute/galleries/${var.gallery_name}/images/${var.image_name}/versions/latest"
  depends_on = [
    azurerm_resource_group.lob_rg,
    azurerm_network_interface.avd_vm_nic,
    azurerm_virtual_desktop_host_pool.hostpool
  ]

  identity {
    type = "SystemAssigned"
  }
  
  lifecycle {
    ignore_changes = [admin_password]
  }

  tags = var.tags

}

resource "azurerm_virtual_machine_extension" "avd_domain_join" {
  count                      = var.rdsh_count
  name                       = "${var.lob_name}-${count.index + 1}-domainJoin"
  virtual_machine_id         = azurerm_windows_virtual_machine.avd_vm.*.id[count.index]
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "Name": "${var.avd_domain_name}",
      "OUPath": "${var.avd_ou_path}",
      "User": "${var.avd_domain_user_upn}@${var.avd_domain_name}",
      "Restart": "true",
      "Options": "3"
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "Password": "${var.avd_domain_password}"
    }
PROTECTED_SETTINGS

  lifecycle {
    ignore_changes = [settings, protected_settings]
  }
}

resource "azurerm_virtual_machine_extension" "vmext_dsc" {
  count                      = var.rdsh_count
  name                       = "${var.lob_name}-${count.index + 1}-vm_extension_avd_dsc"
  virtual_machine_id         = azurerm_windows_virtual_machine.avd_vm.*.id[count.index]
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.73"
  auto_upgrade_minor_version = true

  settings = <<-SETTINGS
    {
      "modulesUrl": "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_09-08-2022.zip",
      "configurationFunction": "Configuration.ps1\\AddSessionHost",
      "properties": {
        "HostPoolName":"${azurerm_virtual_desktop_host_pool.hostpool.name}"
      }
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
  {
    "properties": {
      "registrationInfoToken": "${local.registration_token}"
    }
  }
PROTECTED_SETTINGS

  depends_on = [
    azurerm_virtual_machine_extension.avd_domain_join,
    azurerm_virtual_desktop_host_pool.hostpool
  ]
}

resource "azurerm_network_interface_application_security_group_association" "nic_asg" {
  count                      = var.rdsh_count
  network_interface_id          = azurerm_network_interface.avd_vm_nic.*.id[count.index]
  application_security_group_id = azurerm_application_security_group.lob_asg.id
}

# Enable Daily Autoshutdown
resource "azurerm_dev_test_global_vm_shutdown_schedule" "avd_vm_auto_shut" {
  count                      = var.enable_avd_vm_autoshutdown == true ? var.rdsh_count : 0
  virtual_machine_id         = azurerm_windows_virtual_machine.avd_vm.*.id[count.index]
  location                   = azurerm_resource_group.lob_rg.location
  enabled                    = true

  daily_recurrence_time      = var.avd_vm_autoshut
  timezone                   = "Eastern Standard Time"

  notification_settings {
    enabled                  = false
  }

  lifecycle {
    ignore_changes = [virtual_machine_id]
  }
}



#-------------------AVD Resources------

resource "time_rotating" "avd_regkey" {
  rotation_days = 30
}

# Create AVD workspace
resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = "avd-ws-${var.commonIdentifier}-${var.lob_name}"
  
  location            = azurerm_resource_group.lob_rg.location
  resource_group_name = azurerm_resource_group.lob_rg.name
  friendly_name       = "${var.lob_name} Workspace"
  description         = "${var.lob_name} Workspace"
}

# Create AVD host pool
resource "azurerm_virtual_desktop_host_pool" "hostpool" {
  location                 = azurerm_resource_group.lob_rg.location
  resource_group_name      = azurerm_resource_group.lob_rg.name
  name                     = "avd-hp-${var.commonIdentifier}-${var.lob_name}"
  friendly_name            = "avd-hp-${var.commonIdentifier}-${var.lob_name}"
  validate_environment     = false
  custom_rdp_properties    = var.rdp_properties
  description              = "${var.lob_name} Pooled HostPool"
  type                     = "Pooled"
  maximum_sessions_allowed = var.max_sessions_allowed
  load_balancer_type       = "DepthFirst" #[BreadthFirst DepthFirst]
  start_vm_on_connect      = true
  preferred_app_group_type = var.preferred_app_group_type

  tags = var.tags

  depends_on = [azurerm_resource_group.lob_rg]

  lifecycle {
    ignore_changes = all
  }
}

resource "azurerm_role_definition" "avd_role_def" {
  name               = "Start ${var.lob_name} AVD VM on connect"
  scope              = azurerm_resource_group.lob_rg.id
  description        = "Start ${var.lob_name} AVD VM on connect"

  permissions {
    actions     = [
	      "Microsoft.Compute/VirtualMachines/start/action",
	      "Microsoft.Compute/VirtualMachines/read"
]
    not_actions = []
  }

  assignable_scopes = [
    azurerm_resource_group.lob_rg.id,
  ]
}

resource "azurerm_role_assignment" "power" {
  #name                             = random_uuid.example.result
  scope                            = azurerm_resource_group.lob_rg.id
  role_definition_id               = azurerm_role_definition.avd_role_def.role_definition_resource_id
  principal_id                     = var.avd_object_id //data.azuread_service_principal.spn.application_id
  skip_service_principal_aad_check = true
  #depends_on                       = [data.azurerm_role_definition.power_role]
  
  lifecycle {
    ignore_changes = [role_definition_id]
  }
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registrationinfo" {
  hostpool_id = azurerm_virtual_desktop_host_pool.hostpool.id
  # Generating RFC3339Time for the expiration of the token. 
  expiration_date = time_rotating.avd_regkey.rotation_rfc3339
  #expiration_date = timeadd(timestamp(), "48h")
}

# Create AVD DAG
resource "azurerm_virtual_desktop_application_group" "dag" {
  location            = azurerm_resource_group.lob_rg.location
  resource_group_name = azurerm_resource_group.lob_rg.name
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool.id
  type                = "Desktop"
  name                = "avd-dag-${var.commonIdentifier}-${var.lob_name}"
  friendly_name       = "${var.lob_name} Default Desktop AppGroup"
  description         = "AVD Desktop application group"
  default_desktop_display_name = "${var.lob_name}-${var.commonIdentifier} AVD"
  depends_on          = [azurerm_virtual_desktop_host_pool.hostpool, azurerm_virtual_desktop_workspace.workspace]

  tags = var.tags
}

# Associate Workspace and DAG
resource "azurerm_virtual_desktop_workspace_application_group_association" "ws-dag" {
  application_group_id = azurerm_virtual_desktop_application_group.dag.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
}


#---------------RBAC---------

data "azurerm_role_definition" "role" { # access an existing built-in role
  name = "Desktop Virtualization User"
}

data "azuread_group" "adds_group" {
  display_name     = var.aad_group_name
  security_enabled = true
}

resource "azurerm_role_assignment" "role" {
  scope              = azurerm_virtual_desktop_application_group.dag.id
  role_definition_id = data.azurerm_role_definition.role.id
  principal_id       = data.azuread_group.adds_group.id
  
  lifecycle {
    ignore_changes = [role_definition_id]
  }
}

data "azuread_group" "admin_group" {
  display_name     = "OH-WVD-AZ-DAG-ADMIN_Users"
  security_enabled = true
}

resource "azurerm_role_assignment" "adminrole" {
  scope              = azurerm_virtual_desktop_application_group.dag.id
  role_definition_id = data.azurerm_role_definition.role.id
  principal_id       = data.azuread_group.admin_group.id
  
  lifecycle {
    ignore_changes = [role_definition_id]
  }
}