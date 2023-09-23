######################### FierWall diagram ####################
#-------------+-----------------------------------------------
# Internet    |  SSH  HTTP                         ^   ^   ^
#             |   |     |                          |   |   |
#-------------+---|-----|--------------------------|---|---|-----
# Bastion     |   V     |   _SSH_                  |   |   |
#             |         |   |  |                   |   |  ALL
#-------------+---------|---|--|-------------------|---|----------
# ALB         |         V   |  |  HTTP             |   |
#             |             |  |    |              |  ALL
#-------------+-------------|--|----|--------------|-------------
# App-Servers |             V  |    V  PostgreSQL  |
#             |                |          5432    ALL
#-------------+----------------|-----------|-------------------
# DB-Server   |                V           |
#             |                            V
#-------------+-----------------------------------------------

################################# Application Load Balancer
module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "alb-sg"
  description = "Allowed ingress HTTP traffic"
  vpc_id      = local.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]
  egress_rules        = ["all-all"]
}


################################# Application Servers
module "app_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "app-server-sg"
  description = "Allowed htp traffic from the load balancer"
  vpc_id      = local.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb_sg.security_group_id
    },
    {
      rule                     = "ssh-tcp"
      source_security_group_id = local.bastion_sg
    }
  ]
  egress_rules = ["all-all"]
}

################################# Database Servers
module "db_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "db-server-sg"
  description = "Allowed htp traffic from the load balancer"
  vpc_id      = local.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "postgresql-tcp"
      source_security_group_id = module.app_server_sg.security_group_id
    },
    {
      rule                     = "ssh-tcp"
      source_security_group_id = local.bastion_sg
    }
  ]
  egress_rules = []
}
