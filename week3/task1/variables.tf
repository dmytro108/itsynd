# ******************************** Common vars
variable "region" {
  description = "AWS region for all recources and providers"
  type        = string
  default     = "us-east-1"
}
variable "azs" {
  description = "AWS availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "env_name" {
  description = "Environment tag"
  type        = string
  default     = "Unknown"
}

# ***************************** VPC
variable "vpc_name" {
  description = "VPC name tag"
  type        = string
  default     = "Noname"
}
variable "vpc_cidr_prefix" {
  description = "VPC CIDR base for calculating real VPC CIDRs"
  type        = string
  default     = "10.0.0.0/0"
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
  default     = 1
}
variable "public_subnet_num" {
  description = "Number of public subnets in each VPC"
  type        = number
  default     = 0
}

# ************************************ EC2
variable "ec2_ami_id" {
  description = "AWS AMI id for EC2 instances"
  type        = string
  default     = "ami-0e1c5be2aa956338b" # AWS Linux 2023 x86_64
}
variable "ec2_type" {
  description = "AWS EC2 instance type"
  type        = string
  default     = "t3.micro" # Free tier
}
variable "bastion_pub_key" {
  description = "SSH publick key for access to bastion host"
  type        = string
  default     = ""
}

# ********************************** Launch Template
variable "launch_templ_name" {
  description = "Launch template Name"
  type        = string
  default     = "my-template"
}
variable "launch_templ_descr" {
  description = "Launch template description"
  type        = string
  default     = "Launch Template for an ASG"
}

# ************************************** Auto Scaling Group
variable "asg_name" {
  description = "Autoscaling group name"
  type        = string
  default     = "my-asg"
}
variable "asg_min" {
  description = "Minimal number of EC2 instances in Autoscaling Group"
  type        = number
  default     = 0
}
variable "asg_max" {
  description = "Maximal number of EC2 instances in Autoscaling Group"
  type        = number
  default     = 0
}
variable "asg_desire" {
  description = "Desire number of EC2 instances in Autoscaling Group"
  type        = number
  default     = 0
}

# ***************************** Load Balancer
variable "elb_name" {
  description = "Load Balancer name"
  type = string
  default = "elb"
}
