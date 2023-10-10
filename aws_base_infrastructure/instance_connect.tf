# Coonect to the hosts incide the VPC:
/*
 > aws ec2-instance-connect open-tunnel \
        --instance-id <instance_id> \
        --local-port <local_port> &
*/
# SSh connection:
# > ssh  ec2-user@localhost -p <local_port>
#
resource "aws_ec2_instance_connect_endpoint" "tunnel" {
  subnet_id          = module.vpc.private_subnets[0]
  security_group_ids = [module.sg_tunnel.security_group_id]
}

# ******************* Bastion SG
module "sg_tunnel" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "tunnel-sg"
  description = "Allowed ingress SSH traffic"
  vpc_id      = module.vpc.vpc_id

  # ingress_cidr_blocks = ["0.0.0.0/0"]
  # ingress_rules       = ["ssh-tcp"]
  #ingress_rules = ["all-all"]
  egress_rules  = ["all-all"]
}

# SSH public key
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = var.my_pub_key
}
