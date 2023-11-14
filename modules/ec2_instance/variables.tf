variable "properties" {
  description = "The properties of the AWS EC2 Instance."
  type = object({
    vm_count          = number
    name              = string
    most_recent       = bool
    instance_type     = string
    ami_name          = list(string)
    get_password_data = bool
    tags              = map(string)
  })
}

variable "network_interface_ids" {
  description = "The network IDs by Name."
  type        = map(string)
}

variable "workspaces_az_ids" {
  description = "The availability zone name mapped to ID."
  type        = map(string)
}

variable "customer_shortname" {
  description = "Short name used to name cloud components."
  type        = string
}

variable "default_tags" {
  description = "Tags applied to resources by default if none specified."
  type        = map(string)
}

variable "key_pair" {
  description = "Key pair assigned to EC2 instance."
  type        = string
}