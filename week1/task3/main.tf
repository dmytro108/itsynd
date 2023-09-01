# ********************* EC2 instances *******************************
# Creates an EC2 instance in every created VPC in the private subnet.
# An instance should allow inbound HTTP traffic
# Each instance provisioned with Nginx web server
resource "aws_instance" "web_server" {
  count         = var.vpc_num
  ami           = var.ec2_ami_id
  instance_type = var.ec2_type
  subnet_id     = module.vpc[count.index].private_subnets[0]
  key_name      = aws_key_pair.controller.key_name

  user_data = <<-EOF
                #!/bin/sh
                sudo -i
                yum update
                yum install -y nginx
                echo '<h1> Hello from web server-${count.index} </h1>' > /usr/share/nginx/html/index.html
                nginx
                EOF

  tags = {
    "Name" = "web_server_${count.index}"
  }
}

# ***************************** Security rules ******************************
resource "aws_security_group_rule" "ssh_ingress" {
  description = "Inbound SSH traffic allowed from peered VPCs only. For maintance purposes"
  count             = var.vpc_num
  type              = "ingress"
  from_port         = var.ssh_port_from
  to_port           = var.ssh_port_to
  protocol          = "tcp"
  cidr_blocks       = module.vpc[*].vpc_cidr_block
  security_group_id = module.vpc[count.index].default_security_group_id
}

resource "aws_security_group_rule" "http_ingress" {
  description = "Inbound HTTP traffic allowed from peered VPCs only. For testing web servers"
  count             = var.vpc_num
  type              = "ingress"
  from_port         = var.http_port_from
  to_port           = var.http_port_to
  protocol          = "tcp"
  cidr_blocks       = module.vpc[*].vpc_cidr_block
  security_group_id = module.vpc[count.index].default_security_group_id
}

resource "aws_security_group_rule" "http_egress" {
  description = "Outbound HTTP traffic to everywhere for provisioning purposes"
  count             = var.vpc_num
  type              = "egress"
  from_port         = var.http_port_from
  to_port           = var.http_port_to
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpc[count.index].default_security_group_id
}

resource "aws_security_group_rule" "https_egress" {
  description = "Outbound HTTPS traffic to everywhere for provisioning purposes"
  count             = var.vpc_num
  type              = "egress"
  from_port         = var.https_port_from
  to_port           = var.https_port_to
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpc[count.index].default_security_group_id
}
