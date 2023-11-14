## ---------------------------------------------------------------------------------------------------------------------
## DATA SOURCES
## External input for dynamic resource information gathering
## ---------------------------------------------------------------------------------------------------------------------


data "aws_availability_zones" "available_zones" {
  all_availability_zones = true
  state                  = "available"

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}


data "aws_availability_zone" "zones" {
  for_each = toset(flatten(data.aws_availability_zones.available_zones.*.names))
  name     = each.value
}