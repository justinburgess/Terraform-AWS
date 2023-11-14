variable "default_route_table_id" {
  type = string
}

variable "cidr_block" {
  description = "General properties of the route table."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to apply the route table."
  type        = string
}

variable "internet_gateway_id" {
  description = "The ID of the internet gateway to send internet traffic."
  type        = string
}

variable "customer_shortname" {
  type = string
}

variable "default_tags" {
  description = "Tags applied to all infrastructure."
  type        = map(string)
}
