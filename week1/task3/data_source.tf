data "aws_instances" "nodes_list" {
  count = length(module.vpc)
  filter {
    name   = "subnet-id"
    values = module.vpc[count.index].private_subnets
  }

}
data "aws_vpcs" "my-vpc" {
  filter {
    name   = "tag:Environment"
    values = var.env_name
  }
}
