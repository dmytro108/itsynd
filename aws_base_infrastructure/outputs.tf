output "bastion_public_ip" {
  description = "Bastion node publick IP address"
  value       = aws_eip.bastion.public_ip
}

output "bastion_security_group" {
  description = "ID of the bastion security group"
  value       = module.sg_bastion.security_group_id
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
  description = "Main params of ec2 instance and the key pair"
  value = { ami = var.ec2_ami_id
    type = var.ec2_type
  key = aws_key_pair.bastion.key_name }
}
