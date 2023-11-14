resource "aws_route_table" "internal" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = var.cidr_block
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "${var.nat_gateway_name}-rtb"
  }
}


resource "aws_route_table_association" "internal_by_az" {
  count          = var.association_count
  subnet_id      = var.subnets[count.index]
  route_table_id = aws_route_table.internal.id
}