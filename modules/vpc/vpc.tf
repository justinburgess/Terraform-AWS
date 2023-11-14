resource "aws_vpc" "workspot_vpc" {
  cidr_block         = var.properties.cidr_block
  enable_dns_support = var.properties.enable_dns_support
  tags               = local.all_tags

}

locals {
  all_tags = merge(var.default_tags, var.properties.tags)
}