resource "aws_nat_gateway" "public" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.subnet_id

  tags = merge(
    var.default_tags,
    var.nat_gateway.tags,
    { "az_id" = var.workspace_az_id },
    { Name = "${var.customer_shortname}-nat-gw-${var.workspace_az_id}" }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.

}


resource "aws_eip" "nat" {
  domain = "vpc"
  tags = merge(
    var.default_tags,
    var.nat_gateway.tags,
    { "availability_zone_id" = var.workspace_az_id },
    { Name = "${var.customer_shortname}-nat-gw-eip-${var.workspace_az_id}" }
  )
}