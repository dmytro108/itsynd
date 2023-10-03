terraform {
  backend "s3" {
    bucket         = "its-week3-task3-00"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks-its-week3-task3-00"
  }
}
/*
aws s3  mb --region "us-east-1" s3://its-week3-task1-01
aws dynamodb create-table --table-name terraform-locks-its-week3-task1-01 \
                          --attribute-definitions AttributeName=LockID,AttributeType=S \
                          --key-schema AttributeName=LockID,KeyType=HASH \
                          --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
                          --region "us-east-1"
*/
