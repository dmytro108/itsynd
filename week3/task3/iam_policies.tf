# Assuming to any ec2 instance policy
data "aws_iam_policy_document" "assume_to_ec2" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Read and list all my S3 buckets
data "aws_iam_policy_document" "s3_read_access" {
  statement {
    actions   = ["s3:GetObject", "s3:ListBucket", "s3:ListAllMyBuckets"]
    effect    = "Allow"
    resources = ["arn:aws:s3:::*", "arn:aws:s3:::*/*"]
  }
}


# Policies
resource "aws_iam_policy" "read_bucket" {
  name        = "can-read-bucket"
  description = "Allows to read and list all my s3 buckets"
  policy      = data.aws_iam_policy_document.s3_read_access.json
}
