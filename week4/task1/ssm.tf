locals {
  ssm_endpoints = [
    "com.amazonaws.${var.region}.ssm",
    "com.amazonaws.${var.region}.ssmmessages",
    "com.amazonaws.${var.region}.ec2messages"
  ]
}

resource "aws_vpc_endpoint" "ssm_enpoints" {

  for_each = toset(local.ssm_endpoints)

  service_name = each.value

  vpc_id              = local.vpc_id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = local.public_subnets
  security_group_ids  = [module.smm_endpoints_sg.security_group_id]
}
