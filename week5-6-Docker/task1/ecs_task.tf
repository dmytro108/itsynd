# Create a task definition
resource "aws_ecs_task_definition" "app_task_definition" {
  family                   = "app-task"
  requires_compatibilities = ["EC2"]
  #container_definitions    = file("task-definition.json")
  container_definitions = jsonencode([
    {
      "name" : "sample_django_app",
      "image" : "445545530422.dkr.ecr.us-east-1.amazonaws.com/django_app:latest",
      "networkMode" : "host",
      "environment" : [
        {
          "name" : "DATABASE_URL",
          "value" : "postgres://${var.db_user}:${var.db_password}@${aws_db_instance.postgres.endpoint}/${var.db_name}"
        }
      ],
      "portMappings" : [
        {
          "containerPort" : 8000,
          "hostPort" : 80,
          "protocol" : "tcp"
        }
      ],
      "requiresCompatibilities" : ["EC2"],
      "memory" : 512
    }
  ])
}
