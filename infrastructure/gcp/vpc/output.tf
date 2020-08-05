output "subnetwork" {
  value       = module.gcp-network.subnets
}
output "network" {
  value       = module.gcp-network.network_name
}

output "ip_range_pods" {
  value = module.gcp-network.subnets_names
}

output "ip_range_services" {
  value = module.gcp-network.subnets_secondary_ranges
}