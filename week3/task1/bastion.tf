# AWS EC2 instance placed in a public subnet with publick IP
# This instance is going to use as an access point to the private web servers
resource "aws_instance" "bastion" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_type
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.sg_bastion.security_group_id]
  key_name               = aws_key_pair.bastion.key_name

  tags = {
    "Name" = "Bastion"
  }
}

resource "aws_eip" "bastion" {
  instance = aws_instance.bastion.id
  domain   = "vpc"
}

# ******************* Bastion SG
module "sg_bastion" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "bastion-sg"
  description = "Allowed ingress SSH traffic"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["ssh-tcp"]
  egress_rules  = ["all-all"]
}

# SSH public key
resource "aws_key_pair" "bastion" {
  key_name   = "bastion-key"
  public_key = var.bastion_pub_key
}
