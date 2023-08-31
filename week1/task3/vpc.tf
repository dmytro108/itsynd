locals {
  # list of VPCs CIDR blocks: 10.x.0.0/16
  vpc_cidrs = [for x in range(var.vpc_num) : cidrsubnet(var.vpc_cidr_prefix, 4, x)]

  # map of VPC CIDR blocks with private and bublic subnets CIDRs:
  # {vpc_cidr: 10.x.0.0/16
  # private_subnet_cidrs: 10.x.y.0/24
  # public_subnet_cidrs: 10.x.10y.0/24}
  cidrs = [for vcidr in local.vpc_cidrs : {
    vpc_cidr             = vcidr
    private_subnet_cidrs = [for y in range(var.private_subnet_num) : cidrsubnet(vcidr, 8, y)]
    public_subnet_cidrs  = [for y in range(var.public_subnet_num) : cidrsubnet(vcidr, 8, 100 + y)]
  }]

  # List of VPC peering pairs: ["0,1",...,"0,n",..., "n-1,n"]
  peering_pairs = flatten([for vpc1 in range(var.vpc_num) : [
    for vpc2 in range(vpc1 + 1, var.vpc_num, 1) :
    join(",", [vpc1, vpc2])
    ]
  ])

main_routes_private = flatten([for vpc in range(var.vpc_num) : [for sub in range(var.private_subnet_num) : join(",", [vpc, sub])]])
main_routes_public = flatten([for vpc in range(var.vpc_num) : [for sub in range(var.public_subnet_num) : join(",", [vpc, sub])]])

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
    Environment = "its"
  }
}

## Peering between VPCs
resource "aws_vpc_peering_connection" "peering" {
  for_each    = toset(local.peering_pairs)
  peer_vpc_id = module.vpc[tonumber(split(",", each.value)[0])].vpc_id
  vpc_id      = module.vpc[tonumber(split(",", each.value)[1])].vpc_id
  auto_accept = true
  tags = {
    Name = "peer-${each.value}"
  }
}

# routes
resource "aws_route" "direct_privat" {
  for_each = toset(keys(aws_vpc_peering_connection.peering))

  route_table_id            = module.vpc[tonumber(split(",", each.value)[1])].private_route_table_ids[0]
  destination_cidr_block    = module.vpc[tonumber(split(",", each.value)[0])].vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[each.value].id

}
resource "aws_route" "backward_privat" {
  for_each = toset(keys(aws_vpc_peering_connection.peering))

  route_table_id            = module.vpc[tonumber(split(",", each.value)[0])].private_route_table_ids[0]
  destination_cidr_block    = module.vpc[tonumber(split(",", each.value)[1])].vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[each.value].id

}

resource "aws_route" "direct_public" {
  for_each = toset(keys(aws_vpc_peering_connection.peering))

  route_table_id            = module.vpc[tonumber(split(",", each.value)[1])].public_route_table_ids[0]
  destination_cidr_block    = module.vpc[tonumber(split(",", each.value)[0])].vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[each.value].id

}
resource "aws_route" "backward_public" {
  for_each = toset(keys(aws_vpc_peering_connection.peering))

  route_table_id            = module.vpc[tonumber(split(",", each.value)[0])].public_route_table_ids[0]
  destination_cidr_block    = module.vpc[tonumber(split(",", each.value)[1])].vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[each.value].id

}

/* resource "aws_route_table_association" "private" {
  for_each = toset(local.main_routes_private)

  route_table_id = module.vpc[tonumber(split(",", each.value)[0])].private_route_table_ids[0]
  subnet_id      = module.vpc[tonumber(split(",", each.value)[0])].private_subnets[tonumber(split(",", each.value)[1])]
}

resource "aws_route_table_association" "public" {
  for_each = toset(local.main_routes_public)

  route_table_id = module.vpc[tonumber(split(",", each.value)[0])].public_route_table_ids[0]
  subnet_id      = module.vpc[tonumber(split(",", each.value)[0])].public_subnets[tonumber(split(",", each.value)[1])]
}
 */
# Security rules
resource "aws_security_group_rule" "http-ingress" {
  count             = var.vpc_num
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = local.vpc_cidrs
  security_group_id = module.vpc[count.index].default_security_group_id
}

resource "aws_security_group_rule" "http-egress" {
  count             = var.vpc_num
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       =  ["0.0.0.0/0"]
  security_group_id = module.vpc[count.index].default_security_group_id
}

resource "aws_security_group_rule" "https-egress" {
  count             = var.vpc_num
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpc[count.index].default_security_group_id
}
