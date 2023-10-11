# Create a task definition
resource "aws_ecs_task_definition" "app_task_definition" {
  family                   = "app-task"
  requires_compatibilities = ["EC2"]
  #container_definitions    = file("task-definition.json")
  execution_role_arn = aws_iam_role.task_exec_role.arn
  network_mode       = "awsvpc"
  container_definitions = jsonencode([
    {
      "name" : "sample_django_app",
      "image" : "${local.docker_image}:latest",
      "environment" : [
        {
          "name" : "DATABASE_URL",
          "value" : "postgres://${var.db_user}:${var.db_password}@${aws_db_instance.postgres.endpoint}/${var.db_name}"
        }
      ],
      "portMappings" : [
        {
          "containerPort" : 8000,
          "hostPort" : 8000,
          "protocol" : "tcp"
        }
      ],
      "requiresCompatibilities" : ["EC2"],
      "memory" : 256
      "cpu":100
    }
  ])
}
