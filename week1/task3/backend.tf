terraform {
  backend "s3" {
    bucket         = "its-week1-task3-00"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform_locks"
  }
}
/*
aws dynamodb create-table --table-name terraform_locks \
                          --attribute-definitions AttributeName=LockID,AttributeType=S \
                          --key-schema AttributeName=LockID,KeyType=HASH \
                          --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
*/
