resource "aws_network_interface" "eni" {
  subnet_id       = var.properties.subnet_id
  security_groups = toset([var.properties.security_groups])
  tags = merge(
    var.default_tags,
    { "Name" = var.properties.name },
    { "service_name" = var.properties.service_name }
  )
}