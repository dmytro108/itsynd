terraform {
  /*   backend "s3" {
    bucket         = "its-week1-task3-00"
    key            = "terraform.tfstate"
    region         = var.rgion
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
 */
  backend "local" {

  }
}
