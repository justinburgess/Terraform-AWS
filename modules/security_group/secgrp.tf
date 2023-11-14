resource "aws_security_group" "object" {
  name        = var.properties.name
  description = var.properties.description
  vpc_id      = var.vpc_id
  tags = merge(var.default_tags,
    var.properties.tags,
    { "Name" = "${var.properties.name}" },
  )
}

resource "aws_vpc_security_group_ingress_rule" "irule" {
  security_group_id = aws_security_group.object.id
  for_each          = merge(var.properties.ingress_rules, var.default_rules.ingress_rules)
  description       = each.value.description
  cidr_ipv4         = each.value.cidr_ipv4
  ip_protocol       = each.value.ip_protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  tags              = merge(var.default_tags, each.value.tags)
}


resource "aws_vpc_security_group_egress_rule" "erule" {
  security_group_id = aws_security_group.object.id
  for_each          = merge(var.properties.egress_rules, var.default_rules.egress_rules)
  description       = each.value.description
  cidr_ipv4         = each.value.cidr_ipv4
  ip_protocol       = each.value.ip_protocol
  tags              = merge(var.default_tags, each.value.tags)
}