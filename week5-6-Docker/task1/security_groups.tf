# ------------------------------- Load Balancer SG
module "sg_alb" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "alb-sg"
  description = "Allowed ingress HTTP traffic"
  vpc_id      = local.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]
  egress_rules        = ["all-all"]
}

# ------------------------------- EC2 instances security group
module "sg_app" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "app-sg"
  description = "Allowed htp traffic from the load balancer"
  vpc_id      = local.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.sg_alb.security_group_id
    },
    {
      rule                     = "ssh-tcp"
      source_security_group_id = local.sg_tunnel
    }
  ]
  egress_rules = ["all-all"]
}

# ------------------------------- ECS enpoints security group

module "sg_ecs_endpoints" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "ecs-endpoints-sg"
  description = "Allowed ingress HTTPS traffic"
  vpc_id      = local.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp"]
  egress_rules        = ["all-all"]
}

# --------------------------------- RDS Postgres sg
module "sg_rds_postgres" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "rds-postgres-sg"
  description = "Allowed ingress Postgresql standard traffic"
  vpc_id      = local.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["postgresql-tcp"]
  egress_rules        = ["all-all"]
}
