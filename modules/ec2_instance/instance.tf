data "aws_ami" "image" {
  most_recent = var.properties.most_recent

  filter {
    name   = "name"
    values = var.properties.ami_name
  }

}

resource "aws_instance" "server" {
  count             = var.properties.vm_count
  ami               = data.aws_ami.image.id
  instance_type     = var.properties.instance_type
  availability_zone = keys(var.workspaces_az_ids)[count.index]
  key_name          = var.key_pair
  network_interface {
    network_interface_id = var.network_interface_ids["${format("${var.customer_shortname}-${var.properties.name}-%02d", count.index + 1)}-eni"]
    device_index         = 0
  }
  get_password_data = var.properties.get_password_data
  /* user_data         = var.properties.name == "ec" ? file("./scripts/powershell/Deploy-EC.txt") : file("./scripts/powershell/userdata.txt") */
  tags = merge(var.default_tags,
    { "service_name" = "${var.properties.tags.service}_${count.index + 1}" },
  { "Name" = format("${var.customer_shortname}-${var.properties.name}-%02d", count.index + 1) })
}
