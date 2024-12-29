terraform {
  backend "azurerm" {
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    key                  = var.state_file_name
    sas_token            = var.sas_token
  }
}
provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

module az-rg {
  source = "https://github.com/ChrissR3/terraform/tree/main/modules/az-rg"
 
 az_rg_name     = "rg-tftest-test"
 az_rg_location = "UK South"

}

##module az-vnet {
##  source = "https://github.com/ChrissR3/terraform/tree/main/modules/az-vnet"

##}

##module az-vm {
##  source = "https://github.com/ChrissR3/terraform/tree/main/modules/az-vm"

##}

##module az-vngateway {
##  source = "https://github.com/ChrissR3/terraform/tree/main/modules/vngateway"

##}
