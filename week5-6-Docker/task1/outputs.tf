output "ecr_repo_url" {
  description = "The ECR repository URL"
  value       = aws_ecr_repository.django_app.repository_url
}
output "ecr_registry_id" {
  description = "Defailt ECR registry ID"
  value       = aws_ecr_repository.django_app.registry_id
}
output "database_endpoint" {
  value = aws_db_instance.postgres.endpoint
}
