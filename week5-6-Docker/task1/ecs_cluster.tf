# Create an ECS Cluster
resource "aws_ecs_cluster" "app_cluster" {
  name = "django-app-cluster"
}

# Create a task definition
resource "aws_ecs_task_definition" "app_task_definition" {
  family                   = "app-task"
  requires_compatibilities = ["EC2"]
  #container_definitions    = file("task-definition.json")
  container_definitions    = jsonencode([
    {
      "name": "sample_django_app",
      "image": "445545530422.dkr.ecr.us-east-1.amazonaws.com/sample_django_app:latest",
      "networkMode": "host",
      "environment": [
        {
          "name": "DATABASE_URL",
          "value": "postgres://django:django@localhost:5432/django"
        }
      ],
      "portMappings": [
        {
          "containerPort": 8000,
          "hostPort": 80,
          "protocol": "tcp"
        }
      ],
  "requiresCompatibilities": ["EC2"],
  "memory": 512
    }
])
}

# Create an ECS service
resource "aws_ecs_service" "service" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task_definition.arn
  desired_count   = 2
  launch_type     = "EC2"
/*
  network_configuration {
    security_groups  = [module.sg_app.security_group_id]
    subnets          = local.private_subnets
    assign_public_ip = false
  }
*/
  load_balancer {
    target_group_arn = aws_lb_target_group.app_target_group.arn
    container_name   = "sample_django_app"
    container_port   = 8000
  }

  # depends_on = [ iam_policy ]
  # iam_role =
}
