data "terraform_remote_state" "webapp" {
  backend = "s3"
  config = {
    bucket  = "its-week3-task1-01"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

locals {
  vpc            = data.terraform_remote_state.webapp.outputs.vpc_id
  private_subnet = data.terraform_remote_state.webapp.outputs.private_subnets[0]
  security_group = data.terraform_remote_state.webapp.outputs.sg_webserver
  key_name       = data.terraform_remote_state.webapp.outputs.ec2_instance["key"]
  ec2_ami_id     = data.terraform_remote_state.webapp.outputs.ec2_instance["ami"]
  ec2_type       = data.terraform_remote_state.webapp.outputs.ec2_instance["type"]
}
