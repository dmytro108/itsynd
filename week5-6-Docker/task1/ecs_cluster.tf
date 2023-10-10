# Create an ECS Cluster
resource "aws_ecs_cluster" "app_cluster" {
  name = "django-app-cluster"
}


