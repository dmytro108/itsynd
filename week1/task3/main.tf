
# ********************* EC2 instances
resource "aws_instance" "web_server" {
  count         = var.vpc_num
  ami           = var.ec2_ami_id
  instance_type = var.ec2_type
  subnet_id     = module.vpc[count.index].private_subnets[0]
  key_name      = aws_key_pair.controller.key_name
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

# Security rules
resource "aws_security_group_rule" "http-ingress" {
  count             = var.vpc_num
  type              = "ingress"
  from_port         = var.http_port_from
  to_port           = var.http_port_to
  protocol          = "tcp"
  cidr_blocks       = module.vpc[*].vpc_cidr_block
  security_group_id = module.vpc[count.index].default_security_group_id
}

resource "aws_security_group_rule" "http-egress" {
  count             = var.vpc_num
  type              = "egress"
  from_port         = var.http_port_from
  to_port           = var.http_port_to
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpc[count.index].default_security_group_id
}

resource "aws_security_group_rule" "https-egress" {
  count             = var.vpc_num
  type              = "egress"
  from_port         = var.https_port_from
  to_port           = var.https_port_to
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpc[count.index].default_security_group_id
}
