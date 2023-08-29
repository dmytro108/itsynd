module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  count = 3

  name = "my-vpc-${count.index}"
  cidr = "10.${count.index}.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24"]
  #public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  default_security_group_ingress = [{protocol  = "tcp"
    from_port = 80
    to_port   = 80
    #cidr_blocks = [""]
}]

   default_security_group_egress = [{protocol  = "tcp"
    from_port = 80
    to_port   = 80
    #cidr_blocks = ["0.0.0.0/0"]
}]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_vpc_peering_connection" "peering1to2" {
  peer_vpc_id          = module.vpc[1].vpc_id
  vpc_id               = module.vpc[0].vpc_id
  auto_accept          = true
}
resource "aws_vpc_peering_connection" "peering1to3" {
  peer_vpc_id          = module.vpc[2].vpc_id
  vpc_id               = module.vpc[0].vpc_id
  auto_accept          = true
}
resource "aws_vpc_peering_connection" "peering2to3" {
  peer_vpc_id          = module.vpc[2].vpc_id
  vpc_id               = module.vpc[1].vpc_id
  auto_accept          = true
}

// ********************* EC2 instances
resource "aws_instance" "web_server" {
    count                  = 3
    ami                    = "ami-0e1c5be2aa956338b"
    instance_type          = "t3.micro"
    subnet_id              = module.vpc[count.index].private_subnets[0]
    vpc_security_group_ids = [module.vpc[count.index].default_security_group_id]

    user_data = <<-EOF
                #!/bin/sh
                apt-get update
                apt-get install -y nginx-light
                echo 'Hello from web server-${count.index}' > /var/www/html/index.html
                EOF

    tags = {
        "Name"        = "web_server-${count.index}"
   }
}
