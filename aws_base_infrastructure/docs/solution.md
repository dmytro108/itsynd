### Solution
The infrastructure includes a VPC with public and private subnets in the each of two availability zones. The bastion host placed in one of the public subnets.
#### Infrastructure diagram
![Infrastructure diagram](docs/infra.png)

#### Bastion host security group
![Bastion host SG](docs/fw.png)

#### Using Terraform remote state
The infrastructure accessable with Terraform remote state:
```hcl
data "terraform_remote_state" "base" {
  backend = "s3"
  config = {
    bucket  = "its-base-00"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
```
