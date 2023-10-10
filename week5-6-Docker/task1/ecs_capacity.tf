locals {
  user_data = <<-EOT
    #!/bin/bash
    cat <<'EOF' >> /etc/ecs/ecs.config
    ECS_CLUSTER=django-app-cluster
    ECS_LOGLEVEL=debug
    ECS_CONTAINER_INSTANCE_TAGS={"Name": "django-app"}
    ECS_CONTAINER_INSTANCE_PROPAGATE_TAGS_FROM=ec2_instance
    ECS_ENABLE_TASK_IAM_ROLE=true
    EOF
  EOT
}
data "aws_ssm_parameter" "ecs_optimized_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended"
}

resource "aws_ecs_cluster_capacity_providers" "django_app_capacity" {
  cluster_name       = aws_ecs_cluster.app_cluster.name
  capacity_providers = [aws_ecs_capacity_provider.capacity_asg.name]
  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.capacity_asg.name
  }

}

resource "aws_ecs_capacity_provider" "capacity_asg" {
  name = "capacity-asg"
  auto_scaling_group_provider {
    auto_scaling_group_arn = module.asg.autoscaling_group_arn
    managed_scaling {
      maximum_scaling_step_size = 1000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 10
    }
  }


}

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.10.0"

  # Autoscaling group
  name = "capacity-asg"

  min_size                        = 1
  max_size                        = 3
  desired_capacity                = 2
  wait_for_capacity_timeout       = 0
  health_check_type               = "EC2"
  vpc_zone_identifier             = local.private_subnets
  security_groups                 = [module.sg_app.security_group_id]
  target_group_arns               = [aws_lb_target_group.app_target_group.arn]
  ignore_desired_capacity_changes = true
  create_iam_instance_profile     = true
  iam_role_name                   = "ECS-instance-role"
  iam_role_description            = "ECS role"
  iam_role_policies = {
    AmazonEC2ContainerServiceforEC2Role = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
    AmazonSSMManagedInstanceCore        = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  # Launch template
  launch_template_name        = "app-instance"
  launch_template_description = ""
  update_default_version      = true
  image_id                    = jsondecode(data.aws_ssm_parameter.ecs_optimized_ami.value)["image_id"]
  instance_type               = "t2.micro"
  user_data                   = base64encode(local.user_data)
  key_name                    = local.key_name

  autoscaling_group_tags = {
    AmazonECSManaged    = true
    propagate_at_launch = true
  }
}
