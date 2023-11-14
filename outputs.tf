/* output "gateway_info" {
  value = merge(
    { for k, v in module.elastic_ip : "${k}-eip" => v.eip },
    { for k, v in module.ec2_instance["gateway"].all_servers : k => rsadecrypt(v.password_data, file("./cs-justin-keypair.pem")) }
  )
}

output "enterprise_connector_info" {
  value = merge(
    { for k, v in module.network_interface : v.all.tags.Name => v.all.private_ip if strcontains(v.all.tags.Name, "ec") },
    { for k, v in module.ec2_instance["enterprise_connector"].all_servers : k => rsadecrypt(v.password_data, file("./cs-justin-keypair.pem")) }
  )
} */