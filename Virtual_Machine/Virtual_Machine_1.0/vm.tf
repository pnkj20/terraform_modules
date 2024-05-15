resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vm_name
  computer_name       = var.computer_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm-size
  admin_username      = var.AdminLogin
  admin_password      = var.password
  
  license_type        = "Windows_Server"
  timezone            = "Eastern Standard Time"
  patch_mode = "Manual"
  enable_automatic_updates = false
  encryption_at_host_enabled  = "false"
  availability_set_id = var.vm_set_id

  network_interface_ids = var.vm_nic_id

  boot_diagnostics {
      storage_account_uri = null
  }

  os_disk {
    caching = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    name = var.os_disk_name
    disk_size_gb = var.os_disk_disk_size_gb
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.vSKU
    version   = "latest"
  }
    
  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
