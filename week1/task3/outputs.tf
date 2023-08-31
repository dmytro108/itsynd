output "public_ip" {
  description = "Control node publick IP address"
  value       = aws_eip.controller.public_ip
}

output "my-vpc" {
  description = "VPC id"
  value = data.aws_vpcs.my-vpc.ids
}

output "privat_ips" {
  description = "Control node publick IP address"
  value       = data.aws_instances.nodes_list[*].private_ips
}

 output "cidrs" {
  description = "VPC CIDRs"
  value = module.vpc[*].vpc_cidr_block
 }
