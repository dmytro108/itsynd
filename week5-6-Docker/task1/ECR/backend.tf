terraform {
  backend "s3" {
    bucket         = "its-week5-task1-00"
    key            = "ecr_terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks-its-its-week5-task1-ecr"
  }
}
/*
aws s3  mb --region "us-east-1" s3://its-week5-task1-00
aws dynamodb create-table --table-name terraform-locks-its-week5-task1-ecr \
                          --attribute-definitions AttributeName=LockID,AttributeType=S \
                          --key-schema AttributeName=LockID,KeyType=HASH \
                          --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
                          --region "us-east-1"
*/
