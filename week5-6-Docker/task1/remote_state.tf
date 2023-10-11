data "terraform_remote_state" "base" {
  backend = "s3"
  config = {
    bucket  = "its-base-00"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

data "terraform_remote_state" "ecr" {
  backend = "s3"
  config = {
    bucket  = "its-week5-task1-00"
    key     = "ecr_terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

locals {
  vpc_id          = data.terraform_remote_state.base.outputs.vpc_id
  private_subnets = data.terraform_remote_state.base.outputs.private_subnets
  private_rtables = data.terraform_remote_state.base.outputs.private_subnets_route_tables
  public_subnets  = data.terraform_remote_state.base.outputs.public_subnets
  sg_tunnel       = data.terraform_remote_state.base.outputs.tunnel_security_group
  key_name        = data.terraform_remote_state.base.outputs.ec2_instance["key"]
  ec2_ami_id      = data.terraform_remote_state.base.outputs.ec2_instance["ami"]
  ec2_type        = data.terraform_remote_state.base.outputs.ec2_instance["type"]
  docker_image    = data.terraform_remote_state.ecr.outputs.image_url
}
