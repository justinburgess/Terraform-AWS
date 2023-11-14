output "subnet_info" {
  description = "Creates a map of dmz subnet name to subnet ID."
  value       = aws_subnet.subnet
}