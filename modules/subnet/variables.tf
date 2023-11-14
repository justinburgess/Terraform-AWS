variable "properties" {
  description = "Properties of AWS subnets."
  type = object({
    cidr_blocks = list(string)
    name        = string
    tags        = map(string)
  })
}


variable "vpc_id" {
  description = "The ID of the VPC to place the subnets."
  type        = string
}


variable "workspaces_az_ids" {
  description = "Area Zone map to Area Zone IDs."
  type        = map(string)
}


variable "default_tags" {
  description = "Default tags applied to all Workspot AWS resources."
  type        = map(string)
}