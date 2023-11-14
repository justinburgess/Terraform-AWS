variable "properties" {
  type = object({
    Name : string
    instance_id : string
    private_ip : string
    service_name : string
  })
}


variable "default_tags" {
  type = map(string)
}
