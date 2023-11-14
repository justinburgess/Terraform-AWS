variable "vpc_id" {
  type = string
}

variable "nat_gateway_id" {
  type = string
}


variable "cidr_block" {
  type = string
}


variable "nat_gateway_name" {
  type = string
}

variable "tags" {
  type = map(string)
}


variable "subnets" {
  type = list(string)
}


variable "nat_gateway_az_id" {
  type = string
}


variable "association_count" {
  type = number
}