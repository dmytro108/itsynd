resource "aws_iam_instance_profile" "bucket_reader" {
  name = "bucket-reader"
  role = aws_iam_role.bucket_reader.name
}

resource "aws_iam_instance_profile" "no_bucket_instance" {
  name = "no-bucket-instance"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "bucket_reader" {
  ami                    = local.ec2_ami_id
  instance_type          = local.ec2_type
  subnet_id              = local.private_subnet
  vpc_security_group_ids = [local.security_group]
  key_name               = local.key_name

  iam_instance_profile = aws_iam_instance_profile.bucket_reader.name

  tags = {
    "Name" = "bucket-reader"
  }
}

resource "aws_instance" "ordinary_instance" {
  ami                    = local.ec2_ami_id
  instance_type          = local.ec2_type
  subnet_id              = local.private_subnet
  vpc_security_group_ids = [local.security_group]
  key_name               = local.key_name

  iam_instance_profile = aws_iam_instance_profile.no_bucket_instance.name

  tags = {
    "Name" = "ordinary_instance"
  }
}
