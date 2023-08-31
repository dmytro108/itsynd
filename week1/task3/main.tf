
# ********************* EC2 instances
resource "aws_instance" "web_server" {
  count         = var.vpc_num
  ami           = var.ec2_ami_id
  instance_type = var.ec2_type
  subnet_id     = module.vpc[count.index].private_subnets[0]
  key_name               = aws_key_pair.controller.key_name
  #vpc_security_group_ids = [module.vpc[count.index].default_security_group_id]

  user_data = <<-EOF
                #!/bin/sh
                sudo -i
                yum update
                yum install -y nginx
                echo 'Hello from web server-${count.index}' > /usr/share/nginx/html/index.html
                nginx
                EOF

  tags = {
    "Name" = "web_server-${count.index}"
  }
}

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
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "controller" {
  key_name   = "controller-key"
  public_key = var.controller_pub_key
}

data "aws_instances" "nodes_list" {
  count = length(module.vpc)
filter {
    name   = "subnet-id"
    values = module.vpc[count.index].private_subnets
  }

}
data "aws_vpcs" "my-vpc" {
  tags = {
    Environment = "its"
  }
}
