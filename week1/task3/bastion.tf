# AWS EC2 instance placed in a public subnet with publick IP
# This instance is going to use as an access point to the private web servers
resource "aws_instance" "bastion" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_type
  subnet_id              = module.vpc[0].public_subnets[0]
  vpc_security_group_ids = [aws_security_group.bastion.id]
  key_name               = aws_key_pair.bastion.key_name

  tags = {
    "Name" = "Bastion"
  }
}

resource "aws_eip" "bastion" {
  instance = aws_instance.bastion.id
  domain   = "vpc"
}

resource "aws_security_group" "bastion" {
  vpc_id = module.vpc[0].vpc_id

  ingress {
    description = "Inbound SSH traffic from everyehere to connect to the bastion"
    from_port   = var.ssh_port_from
    to_port     = var.ssh_port_to
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound SSH traffic to peered VPCs only. For connecting to the web servers"
    from_port   = var.ssh_port_from
    to_port     = var.ssh_port_to
    protocol    = "tcp"
    cidr_blocks = module.vpc[*].vpc_cidr_block
  }

  egress {
    description = "Outbound HTTP traffic for provisioning purposes"
    from_port   = var.http_port_from
    to_port     = var.http_port_to
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound HTTPS traffic for provisioning purposes"
    from_port   = var.https_port_from
    to_port     = var.https_port_to
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# SSH public key
resource "aws_key_pair" "bastion" {
  key_name   = "bastion-key"
  public_key = var.bastion_pub_key
}
