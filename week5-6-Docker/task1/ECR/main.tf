resource "aws_ecr_repository" "django_app" {
  name                 = "django-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository_policy" "ecr_repo_policy" {
  repository = aws_ecr_repository.django_app.name
  policy     = data.aws_iam_policy_document.ecr_repo_acces.json
}

# Allow access to the ECR repository for using images
data "aws_iam_policy_document" "ecr_repo_acces" {
  statement {
    sid = "ECRPermissions"
    actions = [
      "ecr:DescribeImages",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetAuthorizationToken",
      "ecr:BatchGetImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:PutImage"
    ]
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}
