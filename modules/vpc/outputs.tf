output "id" {
  description = "The ID of the VPC."
  value       = aws_vpc.workspot_vpc.id
}

output "default_route_table_id" {
  value = aws_vpc.workspot_vpc.default_route_table_id
}