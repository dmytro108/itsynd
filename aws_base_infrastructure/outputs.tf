output "tunnel_security_group" {
  description = "ID of the instance coonect endpoint security group"
  value       = module.sg_tunnel.security_group_id
}

output "vpc_id" {
  description = "The Sandbox VPC id"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "List of private subnets IDs"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of public subnets IDs"
  value       = module.vpc.public_subnets
}

output "ec2_instance" {
  description = "Main params of ec2 instance and the key pair. The map includes {\"ami\": ec2 ami id, \"type\": ec2 instance type, \"key\": keypair key name}"
  value = { ami = var.ec2_ami_id
    type = var.ec2_type
  key = aws_key_pair.my_key.key_name }
}
