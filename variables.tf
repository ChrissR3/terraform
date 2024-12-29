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

