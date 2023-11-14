variable "properties" {
  description = "Properties of the AWS Network Interface."
  type = object({
    name            = string
    security_groups = string
    service         = string
    service_name    = string
    subnet_id       = string
  })
}

variable "default_tags" {
  type = map(string)
}
