# List of EC2 instances with webservers
data "aws_instances" "nodes_list" {
  filter {
    name   = "tag:Environment"
    values = [var.env_name]
  }
  filter {
    name   = "tag:Name"
    values = [for i in range(var.vpc_num) : "web_server_${i}"]
  }
}

# List of created VPCs
data "aws_vpcs" "my_vpc" {
  filter {
    name   = "tag:Environment"
    values = [var.env_name]
  }
}
