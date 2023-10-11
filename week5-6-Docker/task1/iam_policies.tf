# Assume a role to an ECS task
data "aws_iam_policy_document" "ecs_task_role_assume" {
  statement {
    sid     = "ECSTaskRoleAssume"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# task execution IAM role permissions
