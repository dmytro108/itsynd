# The role for instances which can read buckets
resource "aws_iam_role" "bucket_reader" {
  name               = "bucket-reader"
  description        = "The role for instances which can read buckets"
  assume_role_policy = data.aws_iam_policy_document.assume_to_ec2.json
}

# Role for ordinary instance
resource "aws_iam_role" "ec2_role" {
  name               = "ec2-profile-role"
  description        = "Role for ordinary instance"
  assume_role_policy = data.aws_iam_policy_document.assume_to_ec2.json
}

resource "aws_iam_role_policy_attachment" "s3_read_access2bucket_reader" {
  role       = aws_iam_role.bucket_reader.name
  policy_arn = aws_iam_policy.read_bucket.arn
}
