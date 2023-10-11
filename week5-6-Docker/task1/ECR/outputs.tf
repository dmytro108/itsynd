output "image_url" {
  value = aws_ecr_repository.django_app.repository_url
}
/*
aws ecr get-login-password --region ${local.region} \
        | docker login --username AWS \
        --password-stdin ${local.aws_account_id}.dkr.ecr.${local.region}.amazonaws.com

docker tag hello-world:latest ${aws_ecr_repository.django_app.repository_url}:latest
docker push ${aws_ecr_repository.django_app.repository_url}:latest
*/
