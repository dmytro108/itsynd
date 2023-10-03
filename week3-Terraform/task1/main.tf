locals {
  userdata = <<-USERDATA
    #!/bin/sh
    sudo -i
    yum update
    yum install -y docker
    systemctl start docker
    docker run --rm -p 80:3000 ghcr.io/benc-uk/nodejs-demoapp:latest

  USERDATA
}

module "webserver_asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.10.0"

  # Autoscaling group
  name = var.asg_name

  min_size                  = var.asg_min
  max_size                  = var.asg_max
  desired_capacity          = var.asg_desire
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = module.vpc.private_subnets
  security_groups           = [module.sg_webserver.security_group_id]
  target_group_arns         = module.nlb.target_group_arns

  # Launch template
  launch_template_name        = var.launch_templ_name
  launch_template_description = var.launch_templ_descr
  update_default_version      = true
  image_id                    = var.ec2_ami_id
  instance_type               = var.ec2_type
  ebs_optimized               = false
  enable_monitoring           = true
  user_data                   = base64encode(local.userdata)
  key_name                    = aws_key_pair.bastion.key_name

  # Scaling
  scaling_policies = {

    cpu20up = {
      name               = "cpu20up"
      policy_type        = "SimpleScaling"
      adjustment_type    = "ChangeInCapacity"
      scaling_adjustment = 1
      cooldown           = 30
    }
    cpu30up = {
      name               = "cpu30up"
      policy_type        = "SimpleScaling"
      adjustment_type    = "ChangeInCapacity"
      scaling_adjustment = 1
      cooldown           = 30
    }
    cpu40up = {
      name               = "cpu40up"
      policy_type        = "SimpleScaling"
      adjustment_type    = "ChangeInCapacity"
      scaling_adjustment = 2
      cooldown           = 30
    }
    cpu50up = {
      name               = "cpu50up"
      policy_type        = "SimpleScaling"
      adjustment_type    = "ChangeInCapacity"
      scaling_adjustment = 2
      cooldown           = 30
    }

    cpu20down = {
      name               = "cpu20down"
      policy_type        = "SimpleScaling"
      adjustment_type    = "ChangeInCapacity"
      scaling_adjustment = -1
      cooldown           = 30
    }
    cpu30down = {
      name               = "cpu30down"
      policy_type        = "SimpleScaling"
      adjustment_type    = "ChangeInCapacity"
      scaling_adjustment = -1
      cooldown           = 30
    }
    cpu40down = {
      name               = "cpu40down"
      policy_type        = "SimpleScaling"
      adjustment_type    = "ChangeInCapacity"
      scaling_adjustment = -1
      cooldown           = 30
    }
    cpu50down = {
      name               = "cpu50down"
      policy_type        = "SimpleScaling"
      adjustment_type    = "ChangeInCapacity"
      scaling_adjustment = -1
      cooldown           = 30
    }
  }
}
