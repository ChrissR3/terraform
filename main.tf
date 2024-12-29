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
 
 az_rg_name     = "<RESOURCE GROUP NAME>"
 az_rg_location = "UK South"

}

module az-vnet {
  source = "./terraform/modules/az-vnet"
address_space       = ["10.100.0.0/16"]
  location            = "UK South"
  name                = "<NAME OF VNET>"
  resource_group_name = module.az-rg.az-rg-name
  subnets = {
    "subnet1" = {
      name             = "<NAME OF SUBNET>"
      address_prefixes = ["10.100.0.0/24"]
    }
    "subnet2" = {
      name             = "<NAME OF SUBNET>"
      address_prefixes = ["10.100.1.0/24"]
    }
  }

}

module az-vm {
  source = "./terraform/modules/az-vm"
location = "UK South"
name = "<NAME IN AZURE>"
computer_name = "<HOST NAME>"
network_interfaces = {
  network_interface_1 = {
    name = "<NAME>-<NICXX>"
    ip_configurations = {
      ip_configuration_1 = {
        name                          = "<NIC NAME>-ipconfig1"
        private_ip_subnet_resource_id = module.az-vnet.subnets["<SUBNET>"].resource_id
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
