# ******************************** Common vars
variable "region" {
  description = "AWS region for all recources and providers"
  type        = string
  default     = "us-east-1"
}
variable "azs" {
  description = "AWS availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
variable "env_name" {
  description = "Environment tag"
  type        = string
  default     = "ITS-base"
}

# ***************************** VPC
variable "vpc_name" {
  description = "VPC name tag"
  type        = string
  default     = "sandbox"
}
variable "vpc_cidr_prefix" {
  description = "VPC CIDR base for calculating real VPC CIDRs"
  type        = string
  default     = "10.0.0.0/12"
}
variable "vpc_num" {
  description = "Number of VPCs"
  type        = number
  default     = 1
}

# ******************************* Subnets
variable "private_subnet_num" {
  description = "Number of private subnets in each VPC"
  type        = number
  default     = 2
}
variable "public_subnet_num" {
  description = "Number of public subnets in each VPC"
  type        = number
  default     = 2
}

# ************************************ EC2
variable "ec2_ami_id" {
  description = "AWS AMI id for EC2 instances"
  type        = string
  default     = "ami-0e62914c1cb94a559" # Amazon ECS-Optimized Amazon Linux 2023 (AL2023) x86_64 AMI
}
variable "ec2_type" {
  description = "AWS EC2 instance type"
  type        = string
  default     = "t2.micro" # Free tier
}
variable "my_pub_key" {
  description = "SSH publick key for access to all hosts"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDGOVO/Cag0QuYYm5ThB+zehSFbskFjLS1T34y/TxtJ9 bastion"
}
