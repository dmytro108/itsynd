# The role for instances which can read buckets
resource "aws_iam_role" "ssm_managed" {
  name               = "ssm-managed"
  description        = "The role for instances which can use SSM"
  assume_role_policy = data.aws_iam_policy_document.assume_to_ec2.json
}

resource "aws_iam_role_policy_attachment" "ssm_mamaged" {
  role       = aws_iam_role.ssm_managed.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
