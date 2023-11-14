resource "aws_subnet" "subnet" {
  count             = 2
  availability_zone = keys(var.workspaces_az_ids)[count.index]
  vpc_id            = var.vpc_id
  cidr_block        = var.properties.cidr_blocks[count.index]
  tags = merge(var.default_tags,
    var.properties.tags,
    { "az_id" = values(var.workspaces_az_ids)[count.index] },
    { "Name" = "${var.properties.name}-${values(var.workspaces_az_ids)[count.index]}" },
    { "service_name" = "${var.properties.tags.service}_${count.index + 1}" }
  )
}