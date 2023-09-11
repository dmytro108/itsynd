output "public_ip" {
  description = "Control node publick IP address"
  value       = aws_eip.bastion.public_ip
}

output "my_vpc" {
  description = "List of VPC IDs"
  value       = data.aws_vpcs.my_vpc.ids
}

/* output "privat_ips" {
  description = "List of EC2 instances private IPs"
  value       = data.aws_instances.nodes_list.private_ips
}
 */
output "vpc_cidrs" {
  description = "List of VPC CIDRs"
  value       = module.vpc.vpc_cidr_block
}
