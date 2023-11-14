resource "aws_eip" "interface" {
  instance                  = var.properties.instance_id
  domain                    = "vpc"
  associate_with_private_ip = var.properties.private_ip
  tags = merge(var.default_tags,
    { "Name" = "${var.properties.Name}-eip" },
    { "service_name" = "${var.properties.service_name}" }
  )
}

