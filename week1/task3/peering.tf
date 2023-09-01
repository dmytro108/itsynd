locals {
  # List of inxes of VPCs which joint into peering pairs: ["0,1",...,"0,n",..., "n-1,n"]
  # The list contains pairs by the scheme "each to each"
  peering_pairs = flatten([for vpc1 in range(var.vpc_num) : [
    for vpc2 in range(vpc1 + 1, var.vpc_num, 1) :
    join(",", [vpc1, vpc2])
    ]
  ])
}

# VPCs are peering "each to each"
# It creates a VPC peer for each pair of VPC indexes like "0,1"
resource "aws_vpc_peering_connection" "peering" {
  for_each    = toset(local.peering_pairs)
  peer_vpc_id = module.vpc[tonumber(split(",", each.value)[0])].vpc_id
  vpc_id      = module.vpc[tonumber(split(",", each.value)[1])].vpc_id
  auto_accept = true
  tags = {
    Name = "peer-${each.value}"
  }
}

# ************************* Routing ************************************
# It creates a route in the first private subnet routing table of one of peered VPC
# from each peered pair. The route destination is the CIDR of the another peer VPC.
# And the route gateway is the peering connection for these VPCs pair.
# *************************************************************************
# Routes to the requesting VPCs in each peered VPCs pair from the private subned of requested VPC
resource "aws_route" "direct_privat" {
  for_each = toset(keys(aws_vpc_peering_connection.peering))

  route_table_id            = module.vpc[tonumber(split(",", each.value)[1])].private_route_table_ids[0]
  destination_cidr_block    = module.vpc[tonumber(split(",", each.value)[0])].vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[each.value].id
}

# Routes to the requested VPCs in each peered VPCs pair from the private subned of requesting VPC
resource "aws_route" "backward_privat" {
  for_each = toset(keys(aws_vpc_peering_connection.peering))

  route_table_id            = module.vpc[tonumber(split(",", each.value)[0])].private_route_table_ids[0]
  destination_cidr_block    = module.vpc[tonumber(split(",", each.value)[1])].vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[each.value].id
}

# Routes to the requesting VPCs in each peered VPCs pair from the public subned of requested VPC
resource "aws_route" "direct_public" {
  for_each = toset(keys(aws_vpc_peering_connection.peering))

  route_table_id            = module.vpc[tonumber(split(",", each.value)[1])].public_route_table_ids[0]
  destination_cidr_block    = module.vpc[tonumber(split(",", each.value)[0])].vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[each.value].id
}

# Routes to the requested VPCs in each peered VPCs pair from the public subned of requesting VPC
resource "aws_route" "backward_public" {
  for_each = toset(keys(aws_vpc_peering_connection.peering))

  route_table_id            = module.vpc[tonumber(split(",", each.value)[0])].public_route_table_ids[0]
  destination_cidr_block    = module.vpc[tonumber(split(",", each.value)[1])].vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[each.value].id
}
