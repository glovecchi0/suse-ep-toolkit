output "image_id" {
  description = "The ID of the custom OS image used for all RKE2 cluster Azure Virtual Machines instances."
  value       = azurerm_image.harvester.id
}

output "resource_group" {
  description = "Resource group created on Azure account"
  value       = azurerm_resource_group.rg
}