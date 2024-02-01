terraform {
  /*
  backend "s3" {
    bucket         = "gws-useronboard-01"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks-gws-useronboard-01"
  }
*/
  backend "local" {
    path = "terraform.tfstate"
  }
}
/*
aws s3  mb --region "us-east-1" s3://gws-useronboard-01
aws dynamodb create-table --table-name terraform-locks-gws-useronboard-01 \
                          --attribute-definitions AttributeName=LockID,AttributeType=S \
                          --key-schema AttributeName=LockID,KeyType=HASH \
                          --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
                          --region "us-east-1"
*/
