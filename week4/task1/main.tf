locals {
  userdata = <<-USERDATA
    #!/bin/sh
    sudo systemctl restart amazon-ssm-agent

  USERDATA
}

resource "aws_iam_instance_profile" "ssm_enabled" {
  name = "ssm-enabled"
  role = aws_iam_role.ssm_managed.name
}

resource "aws_instance" "app_servers" {
  count = 2

  ami             = local.ec2_ami_id
  instance_type   = local.ec2_type
  subnet_id       = local.public_subnets[count.index]
  key_name        = local.key_name
  security_groups = [module.app_server_sg.security_group_id]
  iam_instance_profile = aws_iam_instance_profile.ssm_enabled.name
  user_data = base64encode(local.userdata)

  tags = {
    "Name" = "app-${count.index}"
  }
}


resource "aws_instance" "db" {

  ami             = local.ec2_ami_id
  instance_type   = local.ec2_type
  subnet_id       = local.private_subnet_1
  key_name        = local.key_name
  security_groups = [module.db_server_sg.security_group_id]
  iam_instance_profile = aws_iam_instance_profile.ssm_enabled.name
  user_data = base64encode(local.userdata)

  tags = {
    "Name" = "database"
  }
}
