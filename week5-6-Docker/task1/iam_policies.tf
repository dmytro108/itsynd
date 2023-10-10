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

/*
# Create an IAM role for the ECS task
resource "aws_iam_role" "task_role" {
  name = "ecs-task-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach an IAM policy to the ECS task role
resource "aws_iam_role_policy_attachment" "task_role_policy_attachment" {
  role       = aws_iam_role.task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerServiceFullAccess"
}
*/
