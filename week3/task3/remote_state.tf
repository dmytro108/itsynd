data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket         = "its-week3-task1-01"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

locals {
  vpc = data.terraform_remote_state.vpc
  subnet = data.terraform_remote_state.vpc
  security_group_id = data.terraform_remote_state.vpc
  key_name = data.terraform_remote_state.vpc
}
