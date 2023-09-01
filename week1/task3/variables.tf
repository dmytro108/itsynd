variable "region" {
  description = "AWS region for all recources and providers"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "VPC name tag"
  type        = string
  default     = "Noname"
}

variable "env_name" {
  description = "Environment tag"
  type        = string
  default     = "Unknown"
}

variable "vpc_cidr_prefix" {
  description = "VPC CIDR base for calculating real VPC CIDRs"
  type        = string
  default     = "10.0.0.0/0"
}

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

variable "azs" {
  description = "AWS availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "vpc_num" {
  description = "Number of VPCs"
  type        = number
  default     = 1

}

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

variable "ssh_port_from" {
  description = "SSH remote port number for security group"
  type        = number
  default     = 22

}
variable "ssh_port_to" {
  description = "SSH local port number for security group"
  type        = number
  default     = 22

}

variable "http_port_from" {
  description = "HTTP remote port number for security group"
  type        = number
  default     = 80

}
variable "http_port_to" {
  description = "HTTP local port number for security group"
  type        = number
  default     = 80

}

variable "https_port_from" {
  description = "HTTPS remote port number for security group"
  type        = number
  default     = 443

}
variable "https_port_to" {
  description = "HTTPS local port number for security group"
  type        = number
  default     = 443

}
variable "controller_pub_key" {
  description = "SSH publick key for access to controller host"
  type        = string
  default     = ""
}
