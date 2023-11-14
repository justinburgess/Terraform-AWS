variable "properties" {
  description = "Properties of the AWS Security Group."
  type = object({
    name          = string
    description   = string
    ingress_rules = any
    egress_rules  = any
    tags          = map(string)
  })
}


variable "default_rules" {
  description = "Rules for all the standard Workspot security groups."
  type = object({
    ingress_rules = any
    egress_rules  = any
  })
}


variable "vpc_id" {
  description = "VPC ID to associate with the Security Group."
  type        = string
}


variable "default_tags" {
  description = "Default tags applied to all Workspot resources."
  type        = map(string)
}