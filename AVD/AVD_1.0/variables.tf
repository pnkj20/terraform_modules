// variable "azure_subscription_id" {
//   description = "The Azure Subscription ID in which to create resources"
// }

// variable "azure_tenant_id" {
//   description = "The Azure Tenant ID in which to find the above subscription"
// }

variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (e.g. 'canadacentral')"
  default = "canadacentral"
}

variable "environment_number" {}
variable "commonIdentifier" {}
variable "projectName" {}

variable "tags" {
  type = map
  description = "Default Tags"
 }

variable "preferred_app_group_type" {
    description = "Preferred app group type"
    default = "Desktop"
 }

// variable "lob_rg_name" {
//   description = "Name of resource group for LoB"
// }

// variable "asg_name" {
//   description = "Name of app security group"
// }

// variable "avd_nic_name" {
//   description = "Name of AVD VM NIC"
// }

variable "env" {
  description = "Environment for which AVD is created like DEV/PRD"
}

variable "lob_name" {
  description = "Line of Business Name"
}

variable "avd_vnet" {
  description = "VNet Name"
  default = "vnet-avd-prod-001"   #avd=avd name eg smr
}

variable "network_rg" {
  description = "Resource Group name for Network"
  default = "rg-avd-network-prod-001"
}

variable "avd_subnet_id" {
  description = "AVD subnet ID"
}
/*
variable "pe_subnet" {
  description = "Private Endpoint subnet"
}

variable "host_subnet" {
  description = "Host VM subnet"
}
*/
variable "aad_group_name" {
  type        = string
  description = "Azure Active Directory Group for AVD users"
}

variable "rdsh_count" {
  description = "Number of AVD machines to deploy"
}

variable "vm_name" {
  description = "Size of the machine to deploy"
}

variable "vm_size" {
  description = "Size of the machine to deploy"
}

variable "local_admin_username" {
  type        = string
  description = "local admin username"
}

variable "image_name" {
  type        = string
  description = "Name of the custome image to use"
}

variable "gallery_name" {
  type        = string
  description = "Name of the shared image gallery name"
}

variable "image_rg" {
  type        = string
  description = "Image Gallery resource group"
}

# Create a storage allow list of IP Addresses
variable "allow_list_ip" {
  type        = list(string)
  description = "List of allowed IP Addresses"
}

variable "max_sessions_allowed" {
  type = number
}

variable "avdshared_subscription_id" {
  type        = string
  description = "Hub Subscription id"
}

// variable "common_rg" {
  
// }

// variable "keyvault_name" {
  
// }
variable "rdp_properties" {
  description = "Custom rdp properties"
}


variable "avd_domain_name" {
  description = "OH Domain" 
}

variable "avd_ou_path" {
  description = "OU for AVD VMs" 
}

variable "avd_domain_user_upn" {
  description = "AVD Domain user to join OH Domain" 
}

variable "avd_domain_password" {
  description = "AVD Domain user password"
}

variable "enable_avd_vm_autoshutdown" {
  type = bool
  default = false
  description = "Enable AVD VM Auto Shutdown"
}

variable "avd_vm_autoshut" {
  description = "AVD VM Auto Shutdown Time"
}

variable "avd_object_id" {
  description = "Windows Virtual Desktop Object ID"
}

variable "avd_local_password" {
  description = "AVD VM local admin password"
}