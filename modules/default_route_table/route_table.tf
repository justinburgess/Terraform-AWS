resource "aws_default_route_table" "main" {
  default_route_table_id = var.default_route_table_id

  route {
    cidr_block = var.cidr_block
    gateway_id = var.internet_gateway_id
  }

  tags = merge(var.default_tags, { "Name" = "${var.customer_shortname}-default-rtb" })
}