locals {
  # map of VPC CIDR blocks with private and bublic subnets CIDRs:
  # {vpc_cidr: 10.x.0.0/16
  # private_subnet_cidrs: 10.x.y.0/24
  # public_subnet_cidrs: 10.x.10y.0/24}
  cidrs = [for vcidr in [for x in range(var.vpc_num) : cidrsubnet(var.vpc_cidr_prefix, 4, x)] : {
    vpc_cidr             = vcidr
    private_subnet_cidrs = [for y in range(var.private_subnet_num) : cidrsubnet(vcidr, 8, y)]
    public_subnet_cidrs  = [for y in range(var.public_subnet_num) : cidrsubnet(vcidr, 8, 100 + y)]
  }]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  count           = var.vpc_num
  azs             = var.azs
  name            = "${var.vpc_name}-${count.index}"
  cidr            = local.cidrs[count.index].vpc_cidr
  private_subnets = local.cidrs[count.index].private_subnet_cidrs
  public_subnets  = local.cidrs[count.index].public_subnet_cidrs

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = var.env_name
  }
}
