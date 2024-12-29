output "application_gateway_ip_configuration_resource_id" {
  description = "The application gateway ip configurations resource id."
  value       = try(azapi_resource.subnet.body.properties.applicationGatewayIPConfigurations.id, null)
}

output "name" {
  description = "The resource name of the subnet."
  value       = azapi_resource.subnet.name
}

output "resource" {
  description = "All attributes of the subnet"
  value       = azapi_resource.subnet
}

output "resource_id" {
  description = "The resource ID of the subnet."
  value       = azapi_resource.subnet.id
}

output "subnet_ids" {
  description = "A map of subnet names to their resource IDs."
  value = {
    subnet1 = azapi_resource.subnet1.id
    subnet2 = azapi_resource.subnet2.id
    subnet3 = azapi_resource.subnet3.id
  }
}
