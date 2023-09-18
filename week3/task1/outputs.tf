output "bastion_public_ip" {
  description = "Bastion node publick IP address"
  value       = aws_eip.bastion.public_ip
}

output "elb_dns" {
  description = "DNS name of the Web service"
  value       = module.nlb.lb_dns_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets

}

output "public_subnets" {
value = module.vpc.public_subnets
}

output "sg_webserver" {
  value = module.sg_webserver.security_group_id
}

output "ec2_instance" {
  value = {ami = var.ec2_ami_id
          type = var.ec2_type}

}
