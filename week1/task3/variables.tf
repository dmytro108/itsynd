variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
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
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/0"
}

variable "pub_net_cidr_prefix" {
  description = "Public subnet CIDR"
  type        = string
  default     = "10.0.0.0/24"
}

variable "priv_net_cidr_prefix" {
  description = "Privat subnet CIDR"
  type        = string
  default     = "10.0.10.0/24"
}

variable "credential_path" {
  description = "Path to credential file"
  type        = string
  default     = "$HOME/.aws/credentials"
}

variable "aws_cli_profile" {
  description = "Profile name in AWS CLI credential and config file"
  type        = string
  default     = "default"
}

variable "ec2_ami_id" {
  description = "AWS ami id"
  type        = string
  default     = "ami-0e1c5be2aa956338b" //AWS Linux 2023 x86_64
}

variable "ec2_type" {
  description = "AWS instance type"
  type        = string
  default     = "t3.micro" // Free tier
}

variable "azs" {
  description = "azs"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

variable "vpc_num" {
  description = "Quantity of VPCs"
  type        = number
  default     = 0

}

variable "subnet_num" {
  description = "Quantity of VPCs"
  type        = number
  default     = 0

}
variable "port_from" {
  description = "Remote port number for security group"
  type        = number
  default     = 80

}
variable "port_to" {
  description = "Local port number for security group"
  type        = number
  default     = 80

}
