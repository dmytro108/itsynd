locals {
  ecs_endpoints = [
      "com.amazonaws.${var.region}.ecs-agent",
      "com.amazonaws.${var.region}.ecs-telemetry",
      "com.amazonaws.${var.region}.ecs",
      "com.amazonaws.${var.region}.ecr.dkr",
      "com.amazonaws.${var.region}.ecr.api",
      "com.amazonaws.${var.region}.s3"
  ]
}

resource "aws_vpc_endpoint" "ecs_endpoints" {

  for_each = toset(local.ecs_endpoints)

  vpc_id = local.vpc_id

  service_name      = each.value
  vpc_endpoint_type = endswith(each.value, ".s3") ? "Gateway" : "Interface"

  subnet_ids          = endswith(each.value, ".s3") ? null : local.public_subnets
  private_dns_enabled = endswith(each.value, ".s3") ? null : true
  security_group_ids  = endswith(each.value, ".s3") ? null : [module.sg_ecs_endpoints.security_group_id]
  route_table_ids     = endswith(each.value, ".s3") ? local.private_rtables : null
}
