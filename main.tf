terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
  }
}


provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}


module "s3_bucket" {
  source = "./modules/s3_bucket"
  tags   = var.default_tags
}


module "vpc" {
  source       = "./modules/vpc"
  properties   = var.vpc
  default_tags = var.default_tags
}


module "subnet" {
  source            = "./modules/subnet"
  for_each          = var.subnets
  workspaces_az_ids = local.workspaces_az_ids
  vpc_id            = module.vpc.id
  properties        = each.value
  default_tags      = var.default_tags
}


module "internet_gateway" {
  source             = "./modules/internet_gateway"
  vpc_id             = module.vpc.id
  customer_shortname = var.customer_shortname
  default_tags       = var.default_tags
}


module "nat_gateway" {
  source             = "./modules/nat_gateway"
  depends_on         = [module.internet_gateway]
  for_each           = local.dmz_subnet_info
  nat_gateway        = var.nat_gateway
  subnet_id          = each.value["subnet_id"]
  workspace_az_id    = each.value["availability_zone_id"]
  customer_shortname = var.customer_shortname
  default_tags       = var.default_tags
}


module "default_route_table" {
  source                 = "./modules/default_route_table"
  default_route_table_id = module.vpc.default_route_table_id
  vpc_id                 = module.vpc.id
  internet_gateway_id    = module.internet_gateway.id
  cidr_block             = var.route_table.cidr_block
  customer_shortname     = var.customer_shortname
  default_tags           = var.default_tags
}


module "route_table" {
  source            = "./modules/route_table"
  for_each          = module.nat_gateway
  vpc_id            = module.vpc.id
  nat_gateway_id    = each.value.nat.id
  nat_gateway_name  = each.value.nat.tags.Name
  nat_gateway_az_id = each.value.nat.tags.az_id
  subnets           = [for subnet in keys(local.subnet_id_to_az_id) : subnet if local.subnet_id_to_az_id[subnet] == each.value.nat.tags.az_id]
  association_count = length([for key in keys(var.subnets) : key if key != "dmz"])
  cidr_block        = "0.0.0.0/0"
  tags              = var.default_tags
}


module "security_group" {
  source        = "./modules/security_group"
  for_each      = var.security_groups
  properties    = merge("${each.value}", { "name" = "${var.customer_shortname}-${each.key}-sg" })
  default_rules = var.security_group_default_rules
  vpc_id        = module.vpc.id
  default_tags  = var.default_tags
}


module "network_interface" {
  source       = "./modules/network_interface"
  count        = length(local.eni_properties)
  properties   = local.eni_properties[count.index]
  default_tags = var.default_tags
}


module "ec2_instance" {
  source                = "./modules/ec2_instance"
  for_each              = var.ec2_instances
  properties            = each.value
  workspaces_az_ids     = local.workspaces_az_ids
  network_interface_ids = { for interface in module.network_interface.*.all : interface.tags["Name"] => interface.id if strcontains(interface.tags["Name"], "${var.customer_shortname}-${each.value.name}") }
  customer_shortname    = var.customer_shortname
  key_pair              = var.key_pair
  default_tags          = var.default_tags
}


module "elastic_ip" {
  source       = "./modules/elastic_ip"
  depends_on   = [module.internet_gateway]
  for_each     = local.ec2_info
  properties   = each.value
  default_tags = var.default_tags
}