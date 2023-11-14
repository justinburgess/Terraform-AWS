variable "nat_gateway" {
  type = object({
    tags = map(string)
  })
}


variable "default_tags" {
  type = map(string)
}


variable "subnet_id" {
  type = string
}

variable "customer_shortname" {
  type = string
}

variable "workspace_az_id" {
  type = string
}