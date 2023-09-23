# The role for instances which satisfies SSM conditions
resource "aws_iam_role" "ssm_managed" {
  name               = "ssm-managed"
  description        = "The role for instances which can use SSM"
  assume_role_policy = data.aws_iam_policy_document.assume_to_ec2.json
}

resource "aws_iam_role_policy_attachment" "ssm_mamaged_core" {
  role       = aws_iam_role.ssm_managed.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
resource "aws_iam_role_policy_attachment" "ssm_mamaged_default" {
  role       = aws_iam_role.ssm_managed.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy"
}
resource "aws_iam_role_policy_attachment" "ssm_mamaged_ec24ssm" {
  role       = aws_iam_role.ssm_managed.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}
