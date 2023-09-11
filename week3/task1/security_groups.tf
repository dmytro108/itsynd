# ******************* Load Balancer SG
module "sg_nlb" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "nlb-sg"
  description = "Allowed ingress HTTP traffic"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["http-80-tcp"]
  egress_rules  = ["all-all"]
}

# ******************* Autoscaling group SG
module "sg_webserver" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "webserver-sg"
  description = "Allowed htp traffic from the load balancer"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.sg_nlb.security_group_id
    }
  ]
  egress_rules = ["all-all"]
}
