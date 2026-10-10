output "connect_instance_storage_configs_id" {
  description = "Map of id values across all connect_instance_storage_configs, keyed the same as var.connect_instance_storage_configs"
  value       = { for k, v in aws_connect_instance_storage_config.connect_instance_storage_configs : k => v.id if v.id != null && length(v.id) > 0 }
}
output "connect_instance_storage_configs_association_id" {
  description = "Map of association_id values across all connect_instance_storage_configs, keyed the same as var.connect_instance_storage_configs"
  value       = { for k, v in aws_connect_instance_storage_config.connect_instance_storage_configs : k => v.association_id if v.association_id != null && length(v.association_id) > 0 }
}
output "connect_instance_storage_configs_instance_id" {
  description = "Map of instance_id values across all connect_instance_storage_configs, keyed the same as var.connect_instance_storage_configs"
  value       = { for k, v in aws_connect_instance_storage_config.connect_instance_storage_configs : k => v.instance_id if v.instance_id != null && length(v.instance_id) > 0 }
}
output "connect_instance_storage_configs_region" {
  description = "Map of region values across all connect_instance_storage_configs, keyed the same as var.connect_instance_storage_configs"
  value       = { for k, v in aws_connect_instance_storage_config.connect_instance_storage_configs : k => v.region if v.region != null && length(v.region) > 0 }
}
output "connect_instance_storage_configs_resource_type" {
  description = "Map of resource_type values across all connect_instance_storage_configs, keyed the same as var.connect_instance_storage_configs"
  value       = { for k, v in aws_connect_instance_storage_config.connect_instance_storage_configs : k => v.resource_type if v.resource_type != null && length(v.resource_type) > 0 }
}
output "connect_instance_storage_configs_storage_config" {
  description = "Map of storage_config values across all connect_instance_storage_configs, keyed the same as var.connect_instance_storage_configs"
  value       = { for k, v in aws_connect_instance_storage_config.connect_instance_storage_configs : k => one(v.storage_config) if v.storage_config != null && length(v.storage_config) > 0 }
}

