output "bastion_public_ip" {
  description = "Bastion node publick IP address"
  value       = aws_eip.bastion.public_ip
}

output "elb_dns" {
  description = "DNS name of the Web service"
  value = module.nlb.lb_dns_name
}
