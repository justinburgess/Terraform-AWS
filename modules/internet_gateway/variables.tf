variable "vpc_id" {
  description = "The ID of the VPC to attach the Internet Gateway."
  type        = string
}

variable "customer_shortname" {
  description = "The shortname of the customer."
  type        = string
}

variable "default_tags" {
  description = "Tags applied to all resources."
  type        = map(string)
}