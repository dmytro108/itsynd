resource "aws_instance" "controller" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_type
  subnet_id              = module.vpc[0].public_subnets[0]
  vpc_security_group_ids = [aws_security_group.controller_public_access.id]
  key_name               = aws_key_pair.controller.key_name

  tags = {
    "Name" = "controller"
  }
}

resource "aws_eip" "controller" {
  instance = aws_instance.controller.id
  domain   = "vpc"
}

resource "aws_security_group" "controller_public_access" {
  vpc_id = module.vpc[0].vpc_id

  ingress {
    from_port   = var.ssh_port_from
    to_port     = var.ssh_port_to
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = var.ssh_port_from
    to_port     = var.ssh_port_to
    protocol    = "tcp"
    cidr_blocks = module.vpc[*].vpc_cidr_block
  }

  egress {
    from_port   = var.http_port_from
    to_port     = var.http_port_to
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = var.https_port_from
    to_port     = var.https_port_to
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "controller" {
  key_name   = "controller-key"
  public_key = var.controller_pub_key
}
