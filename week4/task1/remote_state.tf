data "terraform_remote_state" "base" {
  backend = "s3"
  config = {
    bucket  = "its-base-00"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

}

locals {
  vpc_id           = data.terraform_remote_state.base.outputs.vpc_id
  private_subnet_1 = data.terraform_remote_state.base.outputs.private_subnets[0]
  public_subnets   = data.terraform_remote_state.base.outputs.public_subnets
  bastion_sg       = data.terraform_remote_state.base.outputs.bastion_security_group
  key_name         = data.terraform_remote_state.base.outputs.ec2_instance["key"]
  ec2_ami_id       = data.terraform_remote_state.base.outputs.ec2_instance["ami"]
  ec2_type         = data.terraform_remote_state.base.outputs.ec2_instance["type"]
}
