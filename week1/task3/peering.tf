locals {
  # List of inxes of VPCs which joint into peering pairs: ["0,1",...,"0,n",..., "n-1,n"]
  peering_pairs = flatten([for vpc1 in range(var.vpc_num) : [
    for vpc2 in range(vpc1 + 1, var.vpc_num, 1) :
    join(",", [vpc1, vpc2])
    ]
  ])
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
