resource "aws_internet_gateway" "public" {
  vpc_id = var.vpc_id
  tags   = merge(var.default_tags, { "Name" = "${var.customer_shortname}-igw" })
}