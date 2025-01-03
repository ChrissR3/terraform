terraform {
  backend "azurerm" {
    resource_group_name  = "software-repo-rg"
    storage_account_name = "babblesoftware"
    container_name       = "<Customer Container Name>"
    key                  = "terraform.tfstate"
    sas_token            = "<Insert Container SAS token Here>"
  }
  required_version = ">= 1.9.2"
  
}

provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "azapi" {
  client_id     = var.client_id
  client_secret = var.client_secret
  tenant_id     = var.tenant_id
}

module az-rg {
  source = "./terraform/modules/az-rg" 
 
 az_rg_name     = var.full_rg_name
 az_rg_location = var.rg_location

}

module az-vnet {
  source = "./terraform/modules/az-vnet"
address_space       = ["10.100.0.0/16"]
  location            = var.rg_location
  name                = var.full_vnet_name
  resource_group_name = module.az-rg.az-rg-name
  subnets = {
    "subnet1" = {
      name             = var.full_snet1_name
      address_prefixes = ["10.100.0.0/24"]
    }
    "subnet2" = {
      name             = var.full_snet2_name
      address_prefixes = ["10.100.1.0/24"]
    }
  }

}

module az-vm {
  source = "./terraform/modules/az-vm"
location = "UK South"
name = var.full_vm_name
network_interfaces = {
  network_interface_1 = {
    name = var.vm_nic_name
    ip_configurations = {
      ip_configuration_1 = {
        name                          = var.nic_ipconfig
        private_ip_subnet_resource_id = module.az-vnet.subnets[var.vm_subnet].resource_id
      }
    }
  }
}
resource_group_name = module.az-rg.az-rg-name
zone = null

#
#sku_size = Standard_D2ds_v5 (deafult)
#source_image_reference = (default) {
#  publisher = "MicrosoftWindowsServer"
#  offer     = "WindowsServer"
#  sku       = "2022-Datacenter"
#  version   = "latest"
#}
#admin_username = "Babble.Admin"
#admin_password = "B@bble2024!"

}


##module az-vngateway {
##  source = "./terraform/modules/az-vngateway"

##}
