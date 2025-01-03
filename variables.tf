##Authenticate to Customer Azure Tenant using Service Principal details

variable "client_id" {
  description = "The client ID of the service principal."
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "The client secret of the service principal."
  type        = string
  sensitive   = true
}

variable "subscription_id" {
  description = "The subscription ID where Terraform will operate."
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID of the Azure Active Directory."
  type        = string
}

locals {
  location_map = {
    "UK South" = "uks"
    "UK West"  = "ukw"
  }

  location_code = lookup(local.location_map, var.rg_location, "uks")
}


variable "rg_name" {
  description = "Resource group name without prefix rg-"
  type = string
}

variable "full_rg_name" {
  default = "rg-${var.rg_name}"
}


variable "rg_location" {
  description = "Resource group location, default Uk South"
  type = string
  default = "UK South"
}

variable "vnet_name" {
  description = "Virtual Network Purpose"
  type = string
}

variable "full_vnet_name" {
  default = "vnet-${var.vnet_name}-${local.location_code}"
}

variable "subnet1_name" {
  description = "Subnet 1 Purpose"
  type = string
}

variable "subnet2_name" {
  description = "Subnet 2 Purpose"
  type = string
}

variable "full_snet1_name" {
 default = "snet-${var.subnet1_name}-${local.location_code}-${format("%02d", count.index + 1)}"
} 

variable "full_snet2_name" {
 default = "snet-${var.subnet2_name}-${local.location_code}-${format("%02d", count.index + 1)}"
} 
  

variable "vm_name" {
  description = "Virtual Machine Purpose eg DC,FS,SQL"
  type = string
}

variable "full_vm_name" {
  default = "vm-${var.vm_name}-${local.location_code}-${format("%02d", count.index + 1)}"
}

variable "vm_nic_name" {
  default = "nic-${format("%02d", count.index + 1)}-${var.full_vm_name}"
}

variable "nic_ipconfig" {
  default = "${vm_nic_name}-ipconfig${format("%02d", count.index + 1)}"
}

variable "vm_subnet" {
  description = "Subnet the VM will be placed in, using Map name not the actual name, eg Subnet1 or Subnet2"
  default ="subnet1"
}