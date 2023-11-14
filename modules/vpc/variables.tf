variable "properties" {
  description = "Properties of the VPC."
  type = object({
    cidr_block         = string
    enable_dns_support = bool
    tags               = map(string)
  })
}

variable "default_tags" {
  description = "Default tags applied to fall objects"
  type        = map(string)
}
