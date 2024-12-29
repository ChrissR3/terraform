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

## Backend Authentication to Babble Storage Account

variable "resource_group_name" {
  description = "The name of the resource group containing the storage account."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the Azure storage account."
  type        = string
}

variable "container_name" {
  description = "The name of the blob container."
  type        = string
}

variable "state_file_name" {
  description = "The name of the Terraform state file."
  type        = string
  default     = "terraform.tfstate"
}

variable "sas_token" {
  description = "The SAS token used to authenticate to the Azure Blob Storage."
  type        = string
  sensitive   = true
}