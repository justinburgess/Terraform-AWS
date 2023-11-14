output "map_name_to_id" {
  description = "EC2 instance ID"
  value       = { for server in aws_instance.server : server.tags["service_name"] => server.id }
}

output "name" {
  description = "Name applied to EC2 instance."
  value       = { for server in aws_instance.server : server.tags["service_name"] => server.tags["Name"] }
}

output "all_servers" {
  value = { for server in aws_instance.server : server.tags["Name"] => server }
}