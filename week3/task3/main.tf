resource "aws_iam_instance_profile" "bucket_reader" {
  name = "bucket-reader"
  role = aws_iam_role.bucket_reader.name
}

resource "aws_iam_instance_profile" "ordinary_instance" {
  name = "ordinary-instance"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "bucket_reader" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_type
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.sg_bastion.security_group_id]
  key_name               = aws_key_pair.bastion.key_name

  iam_instance_profile = aws_iam_instance_profile.bucket_reader.name

  tags = {
    "Name" = "bucket-reader"
  }


}
