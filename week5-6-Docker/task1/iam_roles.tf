resource "aws_iam_role" "task_exec_role" {
  name               = "ecs-task-exec-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_role_assume.json
}

# Attach an IAM policy to the ECS task role
resource "aws_iam_role_policy_attachment" "task_role_policy_attachment" {
  role       = aws_iam_role.task_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
