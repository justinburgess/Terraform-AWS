## ---------------------------------------------------------------------------------------------------------------------
## LOCALS
## Modified and filtered information
## ---------------------------------------------------------------------------------------------------------------------


locals {
  # map AZ Name to AZ ID
  workspaces_az_ids = { for k, v in data.aws_availability_zone.zones : k => v.zone_id if contains(var.workspaces_az_ids[var.region], v.zone_id) }

  # Collect output for network_interface
  gw_subnet_ids = { for subnet in module.subnet["dmz"].subnet_info : subnet.tags.service_name => subnet.id }
  ec_subnet_ids = { for subnet in module.subnet["ec_mgmt"].subnet_info : subnet.tags.service_name => subnet.id }

  ec_security_group = { for group in module.security_group.*.ec.map_name_to_id : group.tags.service => group.id }
  gw_security_group = { for group in module.security_group.*.gw.map_name_to_id : group.tags.service => group.id }

  ec_eni_properties = [for i in range(1, var.ec2_instances.enterprise_connector.vm_count + 1) : {
    "service"         = var.ec2_instances.enterprise_connector.tags.service,
    "service_name"    = "${var.ec2_instances.enterprise_connector.tags.service}_${i}",
    "name"            = format("${var.customer_shortname}-${var.ec2_instances.enterprise_connector.name}-%02d-eni", i),
    "subnet_id"       = local.ec_subnet_ids["enterprise_connector_${i}"],
    "security_groups" = local.ec_security_group["enterprise_connector"]
    }
  ]

  gw_eni_properties = [for i in range(1, var.ec2_instances.gateway.vm_count + 1) : {
    "service"         = var.ec2_instances.gateway.tags.service,
    "service_name"    = "${var.ec2_instances.gateway.tags.service}_${i}",
    "name"            = format("${var.customer_shortname}-${var.ec2_instances.gateway.name}-%02d-eni", i),
    "subnet_id"       = local.gw_subnet_ids["gateway_${i}"],
    "security_groups" = local.gw_security_group["gateway"]
    }
  ]

  eni_properties = concat(local.ec_eni_properties, local.gw_eni_properties)

  ec2_info = { for k, v in module.ec2_instance["gateway"].all_servers :
    k => {
      "instance_id"  = v.id,
      "private_ip"   = v.private_ip,
      "Name"         = v.tags.Name,
      "service_name" = v.tags.service_name
    }
  }

  dmz_subnet_info = { for subnet in module.subnet["dmz"].subnet_info : subnet.tags.service_name => { "subnet_id" = subnet.id, "availability_zone_id" = subnet.availability_zone_id } }


  subnet_id_to_az_id = merge([for i in range(2) : { for k, v in module.subnet : v.subnet_info[i].id => v.subnet_info[i].tags.az_id if k != "dmz" }]...)

}